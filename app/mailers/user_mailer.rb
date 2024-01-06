class UserMailer < ApplicationMailer
  
  def verification_email(user)
    
    @user = user
    @verification_token = user.generate_verification_token 

    mail(to: @user.email, subject: 'Account Verification')
  end
end