class InviteMailer < ApplicationMailer
  
  def invite_email
    @invitee = params[:invitee]
    @admin = params[:admin]

    mail(to: @invitee, subject: 'You have been invited to play Weather Together')
  end
end