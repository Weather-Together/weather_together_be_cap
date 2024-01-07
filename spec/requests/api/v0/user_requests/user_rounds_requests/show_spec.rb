require 'rails_helper'

RSpec.describe "User Rounds Show" do
  before :each do
    load_test_data
  end

  it "" do
    get "/api/v1/users/#{@user1.id}/campaigns/#{@round1.id}"

    expect(response).to be_successful

    json_response = JSON.parse(response.body)

    # expect(json_response['data']['id']).to eq(@npc1.id.to_s)
    # expect(json_response['data']['type']).to eq('npc')

    # expect(json_response['data']['attributes']['name']).to eq(@npc1.name)
    # expect(json_response['data']['attributes']['description']).to eq(@npc1.description)
    # expect(json_response['data']['attributes']['gender']).to eq(@npc1.gender)
    # expect(json_response['data']['attributes']['race']).to eq(@npc1.race)
    # expect(json_response['data']['attributes']['klass']).to eq(@npc1.klass)
    # expect(json_response['data']['attributes']['attitude']).to eq(@npc1.attitude)
  end
end