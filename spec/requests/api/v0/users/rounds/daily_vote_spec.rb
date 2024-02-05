require 'rails_helper'

describe "Daily game vote" do
  it "create vote", :vcr do
    test_data
    load_location_coordinates
    new_vote = {
      "lat": "#{@lat2}",
      "lon": "#{@lon2}",
    }

    vote = Vote.find_by(user_id: @user3.id, round_id: @round12)
    vote.destroy

    post "/api/v0/users/#{@user3.id}/rounds/current_daily_round/vote", params: new_vote.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to be_successful
    expect(response.status).to eq(201)


    vote1 = JSON.parse(response.body, symbolize_names: true)[:data]

    vote_attributes = vote1[:attributes]

    expect(vote_attributes).to have_key(:lat)
    expect(vote_attributes[:lat]).to eq("36.53")
    expect(vote_attributes[:lat]).to eq("36.53")
    expect(vote_attributes[:status]).to eq("processed")
    expect(vote_attributes[:score]).to_not be nil
    expect(vote_attributes[:score]).to be_a Float
    expect(vote_attributes[:score]).to_not eq(0)

    vote = Vote.find_by(user_id: @user3.id, round_id: @round12)
  end
end