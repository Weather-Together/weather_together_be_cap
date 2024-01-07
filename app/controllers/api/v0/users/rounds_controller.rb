class Api::V0::Users::RoundsController < ApplicationController
  before_action :set_user

  def show
    if @user
      round = @user.rounds.find(params[:id])
      render json: RoundSerializer.new(round)
    else
      
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def round_params
    params.require(:round).permit(:game_id, :status, :target_weather_stats, :close_date)
  end
end
