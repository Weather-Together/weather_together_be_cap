class User < ApplicationRecord
  has_secure_password

  after_create do
    daily_game = Game.daily_game
    competitive_game = Game.competitive_game
    UserGame.create!(user_id: id, game_id: daily_game.id, invitation: 1)
    UserGame.create!(user_id: id, game_id: competitive_game.id, invitation: 1)
  end

  has_many :votes
  has_many :user_games
  has_many :games, through: :user_games
  has_many :rounds, through: :games

  before_create :generate_verification_token

  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: {with: URI::MailTo::EMAIL_REGEXP}

  enum verified: {unverified: 0, verified: 1, oauth: 2}

  def generate_verification_token
    self.verification_token = SecureRandom.urlsafe_base64
  end

  def previous_public_rounds
    @recent_rounds = rounds
      .where(game_type: 0)
      .order(created_at: :desc)
      .limit(3)
      .includes(:votes)
  end

  def self.username_generator
    "#{Faker::Adjective.positive.capitalize}#{Faker::Creature::Animal.name.capitalize}"
  end

  # STATS FOR DAILY GAMES
  def daily_game_count
     games.find_by(game_type: 2).votes.where(user_id: id).count
  end

  def average_score_in_daily_games
    daily_rounds = rounds.where(game_type: 2)
    daily_votes = Vote.joins(:round).where(rounds: { id: daily_rounds.pluck(:id) })
    daily_votes.average(:score)
  end

  def date_and_score_of_best_daily_score
    lowest_score_vote = Vote.joins(:round).where(rounds: { game_type: 2}).order("votes.score ASC").first
    {date: lowest_score_vote&.round&.process_date, score: lowest_score_vote&.score}
  end



  def grade_book_daily_round
    daily_votes = votes.joins(:round).where(rounds: { game_type: 2 })
    
    score_ranges = {
      '0.00-500.00' => (0.00..500.00),
      '500.01-1000.00' => (500.01..1000.00),
      '1000.01-2000.00' => (1000.01..2000.00),
      '2000.01-5000.00' => (2000.01..5000.00),
      '5000.01-10000.00' => (5000.01..10000.00),
      '10000.01+' => (10000.01..Float::INFINITY)
    }

    result = {}

    score_ranges.each do |range_label, range|
      result[range_label] = daily_votes.where(score: range).count
    end

    result
  end


  #STATS FOR COPETITIVE GAMES 
  
  def self.top_5_competitive_users

    avg_user_score = 
    User.all.map do |user|
      {
        user_id: user.id,
        username: user.username,
        score: user.games.find_by(game_type: 0).votes.where(user_id: user.id).average(:score)
      }
   end
   avg_user_score = avg_user_score.select { |user_hash| user_hash[:score] }
   avg_user_score.sort_by { |user| user[:score] }[0..4]
  #   top_5_users = User.joins(rounds: { votes: :game })
  #                     .select("users.*, avg(votes.score) as 'average_score'")
  #                     .where(rounds: { game_type: 0, status: 2})
  #                     .group('users.id')
  #                     .order('average_score DESC')
  #                     .limit(5)
  #                     .pluck(:username, 'avg(votes.score) as average_score')
   end


  def user_competitive_rank

    avg_user_score = 
    User.all.map do |user|
      {
        user_id: user.id,
        username: user.username,
        score: user.games.find_by(game_type: 0).votes.where(user_id: user.id).average(:score)
      }
   end
   avg_user_score = avg_user_score.select { |user_hash| user_hash[:score] }
   avg_user_score.sort_by { |user| user[:score] }.index { |user| user[:user_id] == id } &.+ 1

    # subquery = rounds
    #   .joins(:game)
    #   .where(games: { game_type: 0, status: :processed })
    #   .group('users.id')
    #   .select('users.id', 'AVG(rounds.score) as average_score')
    #   .to_sql

    # competitive_rank = User
    #   .joins("INNER JOIN (#{subquery}) AS user_scores ON users.id = user_scores.id")
    #   .joins(:rounds)
    #   .where(rounds: { game_type: 0, status: :processed })
    #   .where('user_scores.average_score > ?', votes.average(:score))
    #   .count

    # competitive_rank + 1
  end

  def competitive_game_count
    competitive_rounds = rounds
    .where(rounds: { game_type: 0, status: :processed })
    .order(process_date: :desc)
    # .limit(3)

    rounds_with_votes = competitive_rounds.select do |round|
      round.votes.exists?(user_id: id)
    end.count
  end

  def average_score_in_competitive_games
    competitive_rounds = rounds.joins(:votes).where(game_type: 0, status: :processed)
    competitive_rounds.average('votes.score')
  end

  def top_three_competitive_rounds_by_score
    competitive_rounds = rounds
                          .joins(:votes)
                          .where(game_type: 0, status: :processed)
                          .order('votes.score ASC')
                          .limit(3)
  end

  def last_three_competitive_games_rank
    competitive_rounds = rounds
      .where(rounds: { game_type: 0, status: :processed })
      .order(process_date: :desc)
      # .limit(3)

      rounds_with_votes = competitive_rounds.select do |round|
        round.votes.exists?(user_id: id)
      end[0..2]

    rounds_with_votes.map do |round|
      rank_in_round = round
        .votes
        .joins(:user)
        .where(votes: { status: :processed })
        .order(score: :asc)
        .pluck(:user_id)
        .index(id)

      { round_id: round.id, 
        user_rank: (rank_in_round &.+ 1),
        date: round.close_date,
        total_votes: round.votes.count,
        score: Vote.find_by(user_id: id, round_id: round.id)&.score,
        location: "#{round.region}, #{round.country}"
      }
    end
  end

  def top_three_finishes_competitive
    result = votes.joins(:round).where(rounds: { game_type: 0, status: :processed }).order("votes.score ASC").limit(3)
    result.map { |vote| [vote.round&.process_date, vote.score] }
  end

  #STATS FOR PRIVATE GAMES

  def rank_in_game(game_id)
    game = Game.find_by(id: game_id)
    return unless game

    user_rounds_won = rounds_won_private_games(game_id)
    user_total_score = total_overall_score_private_games(game_id)

    rank = 1

    game.users.each do |user|
      next if user.id == id

      other_user_rounds_won = user.rounds_won_private_games(game_id)
      other_user_total_score = user.total_overall_score_private_games(game_id)

      if other_user_rounds_won > user_rounds_won
        rank += 1
      elsif other_user_rounds_won == user_rounds_won
        rank += 1 if other_user_total_score < user_total_score
      end
    end

    rank
  end

  def total_overall_score_private_games(game_id)
    game = games.find_by(id: game_id)
    return 0 unless game

    total_score = game.votes.where(user_id: id).sum(:score)
    total_score.round(2)
  end


  def rounds_won_private_games(game_id)
    game = games.find_by(id: game_id)
    return 0 unless game

    user_rounds_won = 0

    game.rounds.each do |round|
      lowest_score_in_round = round.votes.minimum(:score)
      user_score_in_round = round.votes.find_by(user_id: id)&.score

      if user_score_in_round && user_score_in_round == lowest_score_in_round
        user_rounds_won += 1
      end
    end

    user_rounds_won
  end

end
