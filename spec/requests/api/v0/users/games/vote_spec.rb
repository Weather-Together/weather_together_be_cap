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
    game_id = JSON.parse(response.body, symbolize_names: true)[:data][:id]
    
    new_vote = {
      "lat": "#{@lat2}",
      "lon": "#{@lon2}",
    }

    allow(Round).to receive(:generate_target_data).and_return(@data11)
    Round.turnover

    post "/api/v0/users/#{@user1.id}/games/#{game_id}/vote", params: new_vote.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to be_successful
    expect(response.status).to eq(201)

    vote = JSON.parse(response.body, symbolize_names: true)[:data]

    vote_attributes = vote[:attributes]

    expect(vote_attributes).to have_key(:lat)
    expect(vote_attributes[:lat]).to eq("36.53")

    accept_invite = {
      rsvp: "accept"
    }
    patch "/api/v0/users/#{@user2.id}/games/#{game_id}" , params: accept_invite.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    post "/api/v0/users/#{@user2.id}/games/#{game_id}/vote", params: new_vote.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to be_successful
    expect(response.status).to eq(201)

    vote = JSON.parse(response.body, symbolize_names: true)[:data]

    vote_attributes = vote[:attributes]

    expect(vote_attributes).to have_key(:lat)
    expect(vote_attributes[:lat]).to eq("36.53")
  end

  it "update vote", :vcr do
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
    game_id = JSON.parse(response.body, symbolize_names: true)[:data][:id]
    
    new_vote = {
      "lat": "#{@lat2}",
      "lon": "#{@lon2}",
    }

    allow(Round).to receive(:generate_target_data).and_return(@data11)
    Round.turnover

    post "/api/v0/users/#{@user1.id}/games/#{game_id}/vote", params: new_vote.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to be_successful
    expect(response.status).to eq(201)

    expect(Vote.all.count).to eq(121)

    new_vote = {
      "lat": "#{@lat3}",
      "lon": "#{@lon3}",
    }

    post "/api/v0/users/#{@user1.id}/games/#{game_id}/vote", params: new_vote.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to be_successful
    expect(response.status).to eq(200)

    expect(Vote.all.count).to eq(121)

    vote = JSON.parse(response.body, symbolize_names: true)[:data]

    vote_attributes = vote[:attributes]

    expect(vote_attributes).to have_key(:lat)
    expect(vote_attributes[:lat]).to eq("39.74")
  end

  it "reject users not in game", :vcr do
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
    game_id = JSON.parse(response.body, symbolize_names: true)[:data][:id]
    
    new_vote = {
      "lat": "#{@lat2}",
      "lon": "#{@lon2}",
    }

    allow(Round).to receive(:generate_target_data).and_return(@data11)
    Round.turnover

    post "/api/v0/users/#{@user4.id}/games/#{game_id}/vote", params: new_vote.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to_not be_successful
    expect(response.status).to eq(401)

    error = JSON.parse(response.body, symbolize_names: true)[:errors].first

    expect(error[:detail]).to eq("User is not in private game")

    post "/api/v0/users/#{@user2.id}/games/#{game_id}/vote", params: new_vote.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to_not be_successful
    expect(response.status).to eq(401)

    error = JSON.parse(response.body, symbolize_names: true)[:errors].first

    expect(error[:detail]).to eq("User is not in private game")
  end
end