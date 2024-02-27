class UserMailer < ApplicationMailer
  
  def verification_email
    @user_id = params[:user_id]
    @email = params[:email]
    @verification_token = params[:verification_token]

    mail(to: @email, subject: 'Account Verification')
  end
end