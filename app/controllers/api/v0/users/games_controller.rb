class Api::V0::Users::GamesController < ApplicationController

  def create
    admin_user = User.find(params[:id])
    Game.create(game_params)
  end

  private

  def game_params
    params.permit(:length_in_days, :guess_lead_time, :player_cap)
  end
end