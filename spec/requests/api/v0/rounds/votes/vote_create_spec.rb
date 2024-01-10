require 'rails_helper'

describe "Vote API" do
  it "create vote", :vcr do
    test_data
    load_location_coordinates
    new_vote = {
      "lat": "#{@lat2}",
      "lon": "#{@lon2}",
    }

    post "/api/v0/users/#{@user3.id}/rounds/#{@round1.id}/votes/new", params: new_vote.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to be_successful
    expect(response.status).to eq(200)


    vote = JSON.parse(response.body, symbolize_names: true)[:data]

    vote_attributes = vote[:attributes]

    expect(vote_attributes).to have_key(:lat)
    expect(vote_attributes[:lat]).to eq("36.53")
  end
end