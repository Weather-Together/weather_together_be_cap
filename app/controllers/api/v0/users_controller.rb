class Api::V0::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    render json: UserSerializer.new(User.all)
  end

  def create
    require 'pry'; binding.pry
    @user = User.new(user_params)
    if @user.save!
      UserMailer.with(user: @user).verification_email.deliver_now
      render json: UserSerializer.new(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def find_or_create
    @user = User.find_or_create_by(email: params[:email])
    @user.update(verified: true)
    render json: UserSerializer.new(@user)
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
        render json: UserSerializer.new(@user)
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
    params.permit(:username, :email, :password, :password_confirmation)
  end
end