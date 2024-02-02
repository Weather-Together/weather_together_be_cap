class Api::V0::Users::GamesController < ApplicationController

  def create
    admin_user = User.find(params[:id])
    game = Game.create(game_params)
    UserGame.create(user_id: admin_user.id, game_id: game.id, invitation: 3)
    render json: GameSerializer.new(game)
  end

  private

  def game_params
    params.permit(:length_in_days, :guess_lead_time, :player_cap)
  end
end