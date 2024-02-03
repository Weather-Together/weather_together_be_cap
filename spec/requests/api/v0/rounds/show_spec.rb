require 'rails_helper'

RSpec.describe "Rounds Show" do
  before :each do
    load_test_data
  end
  
  it "Get request for /rounds/:round_id/results", :vcr do
    get "/api/v0/rounds/#{@round1.id}"

    expect(response).to be_successful
    
    json_response = JSON.parse(response.body)
    #binding.pry
    expect(json_response['data']['id']).to eq(@round1.id.to_s)
    expect(json_response['data']['type']).to eq('round')

    expect(json_response['data']['attributes']['game_id']).to eq(@round1.game.id)
    expect(json_response['data']['attributes']['status']).to eq("open")
    expect(json_response['data']['attributes']['target_weather_stats']).to eq(nil)
    expect(json_response['data']['attributes']['close_date']).to eq(@round1.close_date)

  end
end