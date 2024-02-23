class Api::V0::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    render json: UserSerializer.new(User.all)
  end

  def show
    user = User.find_by(params[:user_id])
    render json: UserSerializer.new(user)
  end

  def create
    begin
      @user = User.create!(user_params)
      UserMailer.with(user: @user).verification_email.deliver_now
      render json: UserSerializer.new(@user)
    rescue ActiveRecord::RecordInvalid => exception
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422)).error_json, status: :unprocessable_entity
    end
  end

  def find_or_create
    @user = User.find_by(email: params[:email], verified: 2)
    @user ||= User.create(email: params[:email],
                          verified: 2,
                          username: User.username_generator,
                          password: "AccThruOAuth1",
                          password_confirmation: "AccThruOAuth1",
                          verification_token: nil)
    render json: UserSerializer.new(@user)
  end

  def verify_account
    @user = User.find_by(id: params[:id], verification_token: params[:token])
    if @user
      @user.update!(verified: 1, verification_token: nil)
      render json: UserSerializer.new(@user), status: :accepted
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

  def daily_stats
    @user = User.find(params[:user_id])


    daily_stats = {
      daily_game_count: @user.daily_game_count,
      average_score_in_daily_games: @user.average_score_in_daily_games,
      date_and_score_of_best_daily_score: @user.date_and_score_of_best_daily_score,
      grade_book_daily_round: @user.grade_book_daily_round
    }

    render json: { daily_stats: daily_stats }
  end

  def competitive_stats
    @user = User.find(params[:user_id])

    competitive_stats = {
      top_5_competitive_users: User.top_5_competitive_users,
      user_competitive_rank: @user.user_competitive_rank,
      competitive_game_count: @user.competitive_game_count,
      average_score_in_competitive_games: @user.average_score_in_competitive_games,
      top_three_competitive_rounds_by_score: @user.top_three_competitive_rounds_by_score,
      last_three_competitive_games_rank: @user.last_three_competitive_games_rank,
      top_three_finishes_competitive: @user.top_three_finishes_competitive
    }

    render json: { competitive_stats: competitive_stats }
  end

  private

  def user_params
    params.permit(:username, :email, :password, :password_confirmation)
  end

  def email_to_username(email)
    email.split("@")[0]
  end
end
