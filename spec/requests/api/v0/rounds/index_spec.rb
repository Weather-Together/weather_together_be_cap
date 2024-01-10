require 'rails_helper'

RSpec.describe "Rounds Show" do
  before :each do
    load_test_data
  end
  
  it "Get all rounds for /rounds" do
    get "/api/v0/rounds"

    expect(response).to be_successful
    
    json_response = JSON.parse(response.body)
    

    expect(json_response['data']).to be_an(Array)
    expect(json_response['data'].length).to eq(4)

    expect(json_response['data'][0]).to have_key("id")
    expect(json_response['data'][0]).to have_key("type")
    expect(json_response['data'][0]).to have_key("attributes")
    expect(json_response['data'][0]['attributes']).to have_key("close_date")
    expect(json_response['data'][0]['attributes']).to have_key("number_of_votes")
    expect(json_response['data'][0]['attributes']).to have_key("target_weather_stats")
    expect(json_response['data'][0]['attributes']).to have_key("status")
    expect(json_response['data'][0]['attributes']).to have_key("game_id")
    expect(json_response['data'][0]['attributes']).to have_key("votes")
  end
end