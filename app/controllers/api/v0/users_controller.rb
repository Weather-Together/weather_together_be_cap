class Api::V0::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.verification_email(@user).deliver_now
      redirect_to(verification_sent_path)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def verify_account
    @user = User.find_by(id: params[:id], verification_token: params[:token])

    if @user
      @user.update(verified: true, verification_token: nil)
      flash[:success] = 'Account verified successfully.'
      redirect_to dashboard_path # Adjust the path as needed
    else
      flash[:error] = 'Invalid verification link.'
      redirect_to root_path # Adjust the path as needed
    end
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      if @user.verified
        # Log the user in
      else
        # Show a message telling the user to verify their email
      end
    else
      # Show an error message
    end
  end

  def recent_rounds
    @user = User.find(params[:user_id])
    rounds = @user.previous_public_rounds
    render json: RoundSerializer.new(rounds)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end