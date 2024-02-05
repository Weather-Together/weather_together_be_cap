require "rails_helper"

describe "users/games create" do
  it "current_community_round", :vcr do
    public_games

    @user1 = User.create!(username: "username1", email: "user1@gmail.com", password: "password1")
    @user2 = User.create!(username: "username2", email: "user2@gmail.com", password: "password1")

    new_game = {
      name: "Storm Chasers",
      length_in_days: 145,
      guess_lead_time: 12,
      player_cap: 12,
      invitees: ["email4@gmail.com", "user2@gmail.com",
        "email3@gmail.com"]
    }
    post "/api/v0/users/#{@user1.id}/games", params: new_game.to_json, headers: {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
    expect(response).to be_successful
    expect(response.status).to eq(200)

    game = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(game).to be_a Hash
    expect(game[:id].to_i).to_not eq(0)
    expect(game[:type]).to eq("game")
    expect(game[:attributes]).to be_a Hash
    expect(game[:attributes][:game_type]).to eq("custom")
    expect(game[:attributes][:name]).to eq("Storm Chasers")
    expect(game[:attributes][:length_in_days]).to eq(145)
    expect(game[:attributes][:guess_lead_time]).to eq(12)
    expect(game[:attributes][:player_cap]).to eq(12)
    expect(game[:attributes][:status]).to eq("open")
    expect(game[:attributes][:start_date]).to be_a String
    expect(game[:attributes][:close_date]).to be_a String

    expect(game[:attributes][:users]).to be_an Array
    expect(game[:attributes][:users].count).to eq(2)
    expect(game[:attributes][:users].first).to be_a Hash
    expect(game[:attributes][:users].first[:id]).to be_a Integer
    expect(game[:attributes][:users].first[:type]).to eq("user")
    expect(game[:attributes][:users].first[:attributes][:email]).to eq("user1@gmail.com")
    expect(game[:attributes][:users].first[:attributes][:username]).to eq("username1")
  end
end
