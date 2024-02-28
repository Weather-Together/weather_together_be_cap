class UpdateMailer 
  def update_email
    @user_id = params[:user_id]
    @email = params[:email]
    @username = params[:username]

    mail(to: @email, subject: "User Profile Update")
  end
end