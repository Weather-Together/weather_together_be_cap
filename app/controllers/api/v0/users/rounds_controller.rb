class Api::V0::Users::RoundsController < ApplicationController

  def show
    @user = User.find(params[:user_id])
    render json: VoteSerializer.new(Rounds.find(params[:id].votes))
  end
end