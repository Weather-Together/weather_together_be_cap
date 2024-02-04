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

end