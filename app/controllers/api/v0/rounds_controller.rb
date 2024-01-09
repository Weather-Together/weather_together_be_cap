class Api::V0::RoundsController < ApplicationController
  def recent_rounds
    rounds = Round.order(created_at: :desc).limit(3)
    render json: RoundSerializer.new(rounds)
  end

  def current_community_round
    current_round = Game.current_community_round
    render json: RoundSerializer.new(current_round)
  end
end