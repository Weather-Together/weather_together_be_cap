class Api::V0::Rounds::VotesController < ApplicationController

  def create
    #check round open
    Vote.create(lat: params[:lat], 
                lon: params[:lon], 
                user_id: params[:user_id],
                round_id: params[:round_id])
    end
end