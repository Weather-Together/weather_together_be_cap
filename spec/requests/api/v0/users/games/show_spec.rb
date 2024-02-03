require 'rails_helper'

describe "respond to invite" do
  it "can succesfully accept invite", :vcr do

    @user1 = User.create!(username: "username1", email: "user1@gmail.com", password: "password1")
    @user2 = User.create!(username: "username2", email: "user2@gmail.com", password: "password1")
    @user3 = User.create!(username: "username3", email: "user3@gmail.com", password: "password1")

    new_game = {
      "name": "Storm Chasers",
      "length_in_days": 145,
      "guess_lead_time": 12,
      "player_cap": 12,
      "invitees": ["user2@gmail.com", "user3@gmail.com"]
      }
      get "/api/v0/users/#{@user2.id}/games/#{game_id}"
    
      
      expect(response).to be_successful
      expect(response.status).to eq(201)
  
      message = JSON.parse(response.body, symbolize_names: true)[:data]

    end
  end
