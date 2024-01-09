require 'rails_helper'

RSpec.describe "Current Community Round", :vcr do
  
  it "get request for /rounds/current_community_rounds" do
    load_test_data
    get "/api/v0/rounds/current_community_round"

    expect(response).to be_successful
    
    json_response = JSON.parse(response.body)
    expect(json_response['data'].length).to eq(3)
  end
end