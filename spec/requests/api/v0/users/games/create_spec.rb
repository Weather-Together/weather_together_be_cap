require 'rails_helper'

describe "users/games create" do
  it "current_community_round", :vcr do
    # test_data
    # load_location_coordinates
    @user1 = User.create!(username: "username1", email: "user1@gmail.com", password: "password1")

    new_game = {
      "length_in_days": 145,
      "guess_lead_time": 12,
      "player_cap": 12,
      "invitees": ["email4@gmail.com", "email2@gmail.com",
                  "email3@gmail.com"]
      }
    post "/api/v0/users/#{@user1.id}/games" , params: new_game.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to be_successful
    expect(response.status).to eq(200)

    game = JSON.parse(response.body, symbolize_names: true)[:data]
  end
end