class Api::V0::Users::RoundsController < ApplicationController
  before_action :set_user

  def show
    if @user
      round = @user.rounds.find(params[:id])
      render json: RoundSerializer.new(round)
    end
  end

  
    def current_community_round
      current_round = Game.current_community_round
      render json: RoundSerializer.new(current_round)
    end

    def current_daily_round
      current_round = Game.current_daily_round
      render json: BulkroundSerializer.new(current_round)
    end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def round_params
    params.require(:round).permit(:game_id)
  end

end


