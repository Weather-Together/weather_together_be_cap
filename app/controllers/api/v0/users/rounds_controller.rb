class Api::V0::Users::RoundsController < ApplicationController
  before_action :set_user

  def show
    if @user
      round = @user.rounds.find(params[:id])
      render json: RoundSerializer.new(round)
    end
  end

  def current_competitive_round
    current_round = Game.current_competitive_round
    render json: RoundSerializer.new(current_round)
  end

  def current_daily_round
    current_round = Game.current_daily_round
    render json: BulkroundSerializer.new(current_round)
  end

  def daily_vote
    round = Game.current_daily_round
    original_lat = params[:lat]
    original_lon = params[:lon]
    vote = Vote.create!(lat: original_lat,
      lon: original_lon,
      user_id: params[:user_id],
      round_id: round.id)
    vote.process
    if (vote.lat.to_f - original_lat.to_f).abs >=0.5 || (vote.lon.to_f - original_lon.to_f).abs >=2.0
        vote.destroy
        render json: { error: 'Your vote is over water. Please pick a new location.' }, status: 400
    else
      render json: VoteSerializer.new(vote), status: 201
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def round_params
    params.require(:round).permit(:game_id)
  end
end
