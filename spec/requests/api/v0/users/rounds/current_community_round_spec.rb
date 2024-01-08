require 'rails_helper'

describe "users/rounds API" do
  it "current_community_round", :vcr do
    test_data
    load_location_coordinates

    get "/api/v0/users/#{@user1.id}/rounds/current_community_round"
    expect(response).to be_successful
    expect(response.status).to eq(200)

    round = JSON.parse(response.body, symbolize_names: true)[:data]
  end
end