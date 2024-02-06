require "rails_helper"

describe "respond to invite" do
  it "can succesfully accept invite", :vcr do
    public_games
    
    @user1 = User.create!(username: "username1", email: "user1@gmail.com", password: "password1")
    @user2 = User.create!(username: "username2", email: "user2@gmail.com", password: "password1")
    @user3 = User.create!(username: "username3", email: "user3@gmail.com", password: "password1")

    new_game = {
                name: "Storm Chasers",
                length_in_days: 145,
                guess_lead_time: 12,
                player_cap: 12,
                invitees: ["user2@gmail.com", "user3@gmail.com"]
               }
    post "/api/v0/users/#{@user1.id}/games", params: new_game.to_json, headers: {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

    game_id = game = JSON.parse(response.body, symbolize_names: true)[:data][:id]

    get "/api/v0/users/#{@user1.id}/games/#{game_id}"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    game = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(game[:id].to_i).to be_an Integer
    expect(game[:id].to_i).to_not eq(0)
    expect(game[:type]).to eq("game")
    expect(game[:attributes][:name]).to eq("Storm Chasers")
    expect(game[:attributes][:game_type]).to eq("custom")
    expect(game[:attributes][:length_in_days]).to eq(145)
    expect(game[:attributes][:guess_lead_time]).to eq(12)
    expect(game[:attributes][:player_cap]).to eq(12)
    expect(game[:attributes][:status]).to eq("open")
    expect(game[:attributes][:start_date]).to eq((Date.today + 1).strftime("%F"))
    expect(game[:attributes][:close_date]).to eq((Date.today + 146).strftime("%F"))
    expect(game[:attributes][:users].count).to eq(3)
    expect(game[:attributes][:users].first[:attributes][:username]).to eq(@user1.username)
  end

    it "can succesfully accept invite", :vcr do
    public_games

    @user1 = User.create!(username: "username1", email: "user1@gmail.com", password: "password1")
    @user2 = User.create!(username: "username2", email: "user2@gmail.com", password: "password1")
    @user3 = User.create!(username: "username3", email: "user3@gmail.com", password: "password1")

    new_game = {
                name: "Storm Chasers",
                length_in_days: 145,
                guess_lead_time: 12,
                player_cap: 12,
                invitees: ["user2@gmail.com", "user3@gmail.com"]
               }
    post "/api/v0/users/#{@user1.id}/games", params: new_game.to_json, headers: {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

    game_id = JSON.parse(response.body, symbolize_names: true)[:data][:id]

    get "/api/v0/users/#{@user2.id}/games/#{game_id}"

    expect(response).to_not be_successful
    expect(response.status).to eq(401)

    message = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(message[:error]).to eq("User must accept invitation to view game")
  end
end
