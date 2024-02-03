class AdminNotifierMailer < ApplicationMailer
  
  def notify_email
    @admin = params[:admin]
    @game_name = params[:game_name]
    @missing_accounts = params[:missing_accounts]

    mail(to: @admin, subject: 'Weather Together - Game invitees without account')
  end
end