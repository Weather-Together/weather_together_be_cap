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
    games.where(game_type: :daily).count
  end

  def average_score_in_daily_games
    daily_rounds = rounds.where(game_type: :daily, status: :processed)
    daily_rounds.average(:score)
  end

  def date_and_score_of_best_daily_score
    lowest_score_round = rounds.where(game_type: :daily, status: :processed).order(score: :asc).first

    if lowest_score_round
      {date: lowest_score_round.created_at.to_date, score: lowest_score_round.score}
    else
      {date: nil, score: nil}
    end
  end

  def grade_book_daily_round
    daily_rounds = rounds.where(game_type: :daily, status: :processed)

    score_ranges = {
      "0.00-500.00" => (0.00..500.00),
      "500.01-1000.00" => (500.01..1000.00),
      "1000.01-2000.00" => (1000.01..2000.00),
      "2000.01-5000.00" => (2000.01..5000.00),
      "5000.01+" => (5000.01..Float::INFINITY)
    }

    result = {}

    score_ranges.each do |range_label, range|
      result[range_label] = daily_rounds.where(score: range).count
    end

    result
  end

  # STATS FOR COPETITIVE GAMES

  def self.top_5_competitive_users
    User.joins(rounds: :game)
      .where("rounds.game_type = ? AND rounds.status = ? AND rounds.process_date IS NOT NULL", Game.game_types[:competitive], Game.statuses[:processed])
      .group("users.id")
      .order("AVG(rounds.score) DESC")
      .limit(5)
      .pluck(:username, "AVG(rounds.score) AS average_score")
  end

  def user_competitive_rank
    subquery = rounds
      .joins(:game)
      .where(games: {game_type: :competitive, status: :processed})
      .group("users.id")
      .select("users.id", "AVG(rounds.score) as average_score")
      .to_sql

    competitive_rounds = User
      .joins("INNER JOIN (#{subquery}) AS user_scores ON users.id = user_scores.id")
      .where("average_score < ?", rounds.average(:score))
      .count

    competitive_rounds + 1
  end

  def competitive_game_count
    games.where(game_type: :competitive).count
  end

  def average_score_in_competitive_games
    competitive_rounds = rounds.where(game_type: :competitive, status: :processed)
    competitive_rounds.average(:score)
  end

  def top_three_competitive_rounds_by_score
    competitive_rounds = rounds.where(game_type: :competitive, status: :processed).order(score: :asc).limit(3)
  end

  def last_three_competitive_games_rank
    competitive_rounds = rounds
      .joins(:game)  # Assuming there's an association between rounds and games
      .where(games: {game_type: :competitive, status: :processed})
      .order(date: :desc)
      .limit(3)

    competitive_rounds.map do |round|
      rank_in_round = round
        .votes
        .joins(:user)
        .where(votes: {status: :processed})
        .order("votes.score ASC")
        .pluck(:user_id)
        .index(id)

      {round_id: round.id, user_rank: rank_in_round + 1}
    end
  end

  def top_three_finishes_competitive
    competitive_rounds = rounds
      .where(game_type: :competitive, status: :processed)
      .order(score: :asc)
      .limit(3)
  end
end
