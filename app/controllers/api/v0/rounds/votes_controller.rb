class Api::V0::Rounds::VotesController < ApplicationController

  def create
    #error handle for no user/no round :404
    #error handle for round closed :422
    #check if user has voted
    vote = Vote.create(lat: params[:lat], 
                lon: params[:lon], 
                user_id: params[:user_id],
                round_id: params[:round_id])
    render json: VoteSerializer.new(vote)
  end

  def index
    render json: VoteSerializer.new(Rounds.find(params[:id].votes))
  end
end