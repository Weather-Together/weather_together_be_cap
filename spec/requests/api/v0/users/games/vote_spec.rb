require 'rails_helper'

describe "Game submit vote" do
  it "submit vote to private game", :vcr do
    test_data
    public_games
    load_location_coordinates

    new_game = {
      "name": "Storm Chasers",
      "length_in_days": 145,
      "guess_lead_time": 12,
      "player_cap": 12,
      "invitees": ["user2@gmail.com", "user3@gmail.com"]
      }
    post "/api/v0/users/#{@user1.id}/games" , params: new_game.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    game_id = game = JSON.parse(response.body, symbolize_names: true)[:data][:id]
    
    new_vote = {
      "lat": "#{@lat2}",
      "lon": "#{@lon2}",
    }

    Round.turnover

    post "/api/v0/users/#{@user1.id}/games/#{game_id}/votes/new", params: new_vote.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to be_successful
    expect(response.status).to eq(201)


    vote = JSON.parse(response.body, symbolize_names: true)[:data]

    vote_attributes = vote[:attributes]

    expect(vote_attributes).to have_key(:lat)
    expect(vote_attributes[:lat]).to eq("36.53")
  end

  it "update vote", :vcr do
    test_data
    load_location_coordinates
    new_vote = {
      "lat": "#{@lat2}",
      "lon": "#{@lon2}",
    }

    post "/api/v0/users/#{@user3.id}/rounds/#{@round.id}/votes/new", params: new_vote.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to be_successful
    expect(response.status).to eq(200)


    vote = JSON.parse(response.body, symbolize_names: true)[:data]

    vote_attributes = vote[:attributes]

    expect(vote_attributes).to have_key(:lat)
    expect(vote_attributes[:lat]).to eq("36.53")
  end
end