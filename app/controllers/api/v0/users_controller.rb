class Api::V0::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    render json: UserSerializer.new(User.all)
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      UserMailer.with(user: @user).verification_email.deliver_now
      render json: UserSerializer.new(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def find_or_create
    @user = User.find_or_create_by(email: params[:email], 
                                   username: email_to_username(params[:email]), 
                                   password: "AccThruOAuth1", 
                                   confirm_password: "AccThruOAuth1", 
                                   verified: 2, 
                                   verification_token: nil)
    render json: UserSerializer.new(@user)
  end

  def verify_account
    @user = User.find_by(id: params[:id], verification_token: params[:token])
    if @user
      @user.update!(verified: 1, verification_token: nil)
      render json: { "message": "Successfully verified user"}, status: :accepted
    else
      render json: ErrorSerializer.new(ErrorMessage.new("Email does not match verification token", 422)).error_json, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      if @user.unverified?
        render json: ErrorSerializer.new(ErrorMessage.new("User must verify email", 401)).error_json, status: :unauthorized
      elsif @user.oauth?
        render json: ErrorSerializer.new(ErrorMessage.new("User must sign in through Google OAuth", 401)).error_json, status: :unauthorized
      else
        render json: UserSerializer.new(@user)
      end
    else
      render json: ErrorSerializer.new(ErrorMessage.new("Email and/or password are incorrect", 401)).error_json, status: :unauthorized
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

  def email_to_username(email)
    email.split("@")[0]
  end
end