class UserMailer < ApplicationMailer
  
  def verification_email
    @user = params[:user]
    @verification_token = params[:user].verification_token 

    mail(to: @user.email, subject: 'Account Verification')
  end
end