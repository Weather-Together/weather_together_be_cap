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
    vote = Vote.create!(lat: original_lat, lon: original_lon, user_id: params[:user_id], round_id: round.id)
    vote.process

    if valid_location?(original_lat, original_lon, vote.lat, vote.lon)
      vote.get_location_information
      UserStatsJob.perform_async(params[:user_id])
      render json: VoteSerializer.new(vote), status: 201
    else
      vote.destroy
      render json: { error: 'Your vote is over water. Please pick a new location.' }, status: 422
    end
  end

  private

  def valid_location?(original_lat, original_lon, lat, lon)
    (lat.to_f - original_lat.to_f).abs < 0.5 && (lon.to_f - original_lon.to_f).abs < 2.0
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def round_params
    params.require(:round).permit(:game_id)
  end
end
