class Api::V0::RoundsController < ApplicationController
  def recent_rounds
    rounds = Round.order(created_at: :desc).limit(4)
    render json: RoundSerializer.new(rounds)
  end

  def current_competitive_round
    current_round = Game.current_competitive_round
    render json: RoundSerializer.new(current_round)
  end

  def show
    round = Round.find(params[:id])
    render json: RoundSerializer.new(round)
  end

  def index
    rounds = Round.all
    render json: BulkroundSerializer.new(rounds.order(close_date: :desc))
  end

  def round_statistics
    round = Round.find(params[:round_id])

    daily_stats = {
      daily_game_count: round.daily_game_count,
      average_score_in_daily_games: round.average_score_in_daily_games,
      date_and_score_of_best_daily_score: round.date_and_score_of_best_daily_score,
      grade_book_daily_round: round.grade_book_daily_round
    }

    competitive_stats = {
      top_5_competitive_users: round.top_5_competitive_users,
      user_competitive_rank: round.user_competitive_rank,
      competitive_game_count: round.competitive_game_count,
      average_score_in_competitive_games: round.average_score_in_competitive_games,
      top_three_competitive_rounds_by_score: round.top_three_competitive_rounds_by_score,
      last_three_competitive_games_rank: round.last_three_competitive_games_rank,
      top_three_finishes_competitive: round.top_three_finishes_competitive
    }

    render json: { daily_stats: daily_stats, competitive_stats: competitive_stats }
  end

end