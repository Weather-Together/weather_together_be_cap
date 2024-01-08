require 'rails_helper'

RSpec.describe "User Recent Rounds" do
  before :each do
    load_test_data
  end
  
  it "get request for /users/:user_id/recent_rounds (info: 3 most recents public rounds with votes, vote content, placement in round)" do
    get "/api/v0/users/#{@user1.id}/recent_rounds"

    expect(response).to be_successful
    
    json_response = JSON.parse(response.body)
    #binding.pry
    expect(json_response['data'].length).to eq(3)

    expect(json_response['data'][0]['id']).to eq(@round3.id.to_s)
    expect(json_response['data'][0]['type']).to eq('round')

    expect(json_response['data'][0]['attributes']['game_id']).to eq(@round3.game.id)
    expect(json_response['data'][0]['attributes']['status']).to eq("open")
    expect(json_response['data'][0]['attributes']['target_weather_stats']).to eq(nil)
    expect(json_response['data'][0]['attributes']['close_date']).to eq(@round3.close_date)
    expect(json_response['data'][0]['attributes']).to have_key('votes')

    expect(json_response['data'][1]['id']).to eq(@round2.id.to_s)
    expect(json_response['data'][1]['type']).to eq('round')

    expect(json_response['data'][1]['attributes']['game_id']).to eq(@round2.game.id)
    expect(json_response['data'][1]['attributes']['status']).to eq("open")
    expect(json_response['data'][1]['attributes']['target_weather_stats']).to eq(nil)
    expect(json_response['data'][1]['attributes']['close_date']).to eq(@round2.close_date)
    expect(json_response['data'][1]['attributes']).to have_key('votes')

    expect(json_response['data'][2]['id']).to eq(@round1.id.to_s)
    expect(json_response['data'][2]['type']).to eq('round')

    expect(json_response['data'][2]['attributes']['game_id']).to eq(@round1.game.id)
    expect(json_response['data'][2]['attributes']['status']).to eq("open")
    expect(json_response['data'][2]['attributes']['target_weather_stats']).to eq(nil)
    expect(json_response['data'][2]['attributes']['close_date']).to eq(@round1.close_date)
    expect(json_response['data'][2]['attributes']).to have_key('votes')

    expect(json_response['data'][2]['attributes']['votes'][0]).to have_key('vote_id')
    expect(json_response['data'][2]['attributes']['votes'][0]).to have_key('user_id')
    expect(json_response['data'][2]['attributes']['votes'][0]).to have_key('round_id')
    expect(json_response['data'][2]['attributes']['votes'][0]).to have_key('status')
    expect(json_response['data'][2]['attributes']['votes'][0]).to have_key('target_weather_stats')
    expect(json_response['data'][2]['attributes']['votes'][0]).to have_key('latitude')
    expect(json_response['data'][2]['attributes']['votes'][0]).to have_key('longitude')
    expect(json_response['data'][2]['attributes']['votes'][0]).to have_key('weather_stats')
    expect(json_response['data'][2]['attributes']['votes'][0]).to have_key('score')

  end
end