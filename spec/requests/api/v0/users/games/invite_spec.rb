require 'rails_helper'

describe "respond to invite" do
  it "can succesfully accept invite", :vcr do
    public_games
    
    @user1 = User.create!(username: "username1", email: "user1@gmail.com", password: "password1")
    @user2 = User.create!(username: "username2", email: "user2@gmail.com", password: "password1")
    @user3 = User.create!(username: "username3", email: "user3@gmail.com", password: "password1")
    @user4 = User.create!(username: "username4", email: "user4@gmail.com", password: "password1")

    new_game = {
      "name": "Storm Chasers",
      "length_in_days": 145,
      "guess_lead_time": 12,
      "player_cap": 12,
      "invitees": ["user2@gmail.com", "user3@gmail.com"]
      }
    post "/api/v0/users/#{@user1.id}/games" , params: new_game.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    
    game_id = game = JSON.parse(response.body, symbolize_names: true)[:data][:id]
    expect(UserGame.find_by(user_id: @user4.id, game_id: game_id)).to be nil
    
    new_invites = {
      "invitees": ["user4@gmail.com", "user5@gmail.com"]
      }
    post "/api/v0/users/#{@user1.id}/games/#{game_id}/invite" , params: new_invites.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    
    expect(response).to be_successful
    expect(response.status).to eq(201)

    message = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(message[:message]).to eq("Successfully Sent Invitation")
    expect(UserGame.find_by(user_id: @user4.id, game_id: game_id)).to_not be nil

    end
  end

