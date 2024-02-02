class Api::V0::Users::GamesController < ApplicationController

  def create
    admin_user = User.find(params[:id])
    game = Game.create(game_params)
    UserGame.create(user_id: admin_user.id, game_id: game.id, invitation: 3)
    missing_accounts = []
    params[:invitees].each do |email|
      invitee = User.find_by(email: email)
      if invitee
        UserGame.create(user_id: invitee.id, game_id: game.id)
      else
        missing_accounts << email
        InviteMailer.with(invitee: email, admin: admin_user.username).invite_email.deliver_now
      end
    end
    unless missing_accounts.empty?
      AdminNotifierMailer.with(admin: admin_user.email, game_name: game.name, missing_accounts: missing_accounts ).notify_email.deliver_now
    end
    render json: GameSerializer.new(game)
  end

  private

  def game_params
    params.permit(:length_in_days, :guess_lead_time, :player_cap, :name)
  end
end