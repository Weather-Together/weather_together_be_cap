class Api::V0::Rounds::VotesController < ApplicationController

  def create
    begin
      @user = User.find(params[:user_id])
      @round = Round.find(params[:round_id])
    rescue ActiveRecord::RecordNotFound => exception
      render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).error_json, status: :not_found
    end
    if @round.open?
      vote = Vote.find_by( user_id: params[:user_id],
                           round_id: params[:round_id])
        if vote
          vote = Vote.update( lat: params[:lat], 
                              lon: params[:lon], 
                              user_id: params[:user_id],
                              round_id: params[:round_id])
          render json: VoteSerializer.new(vote), status: :ok
        else
        vote = Vote.create( lat: params[:lat], 
                            lon: params[:lon], 
                            user_id: params[:user_id],
                            round_id: params[:round_id])
        render json: VoteSerializer.new(vote), status: :created
      end
    else
      render json: ErrorSerializer.new(ErrorMessage.new("Round is closed for voting", 428)).error_json, status: :precondition_required
    end
  end

  def index
    render json: VoteSerializer.new(Round.find(params[:id].votes))
  end
end