class Api::V0::RoundsController < ApplicationController
  def recent_rounds
    rounds = Round.order(created_at: :desc).limit(3)
    render json: RoundSerializer.new(rounds)
  end
end