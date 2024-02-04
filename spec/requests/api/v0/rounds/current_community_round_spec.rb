require 'rails_helper'

RSpec.describe "Current Competitive Round", :vcr do
  
  it "get request for /rounds/current_competitive_round" do
    load_test_data
    get "/api/v0/rounds/current_community_round"

    expect(response).to be_successful
    
    round = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(round[:type]).to eq("round")
    expect(round[:attributes][:status]).to eq("open")
    expect(round[:attributes][:close_date]).to eq((Date.today+1).strftime('%F'))
  end
end