require 'rails_helper'

describe "users/rounds API" do
  it "current_competitive_round", :vcr do
    test_data

    get "/api/v0/users/#{@user1.id}/rounds/current_competitive_round"
    expect(response).to be_successful
    expect(response.status).to eq(200)

    round = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(round[:type]).to eq("round")
    expect(round[:attributes][:status]).to eq("open")
    expect(round[:attributes][:close_date]).to eq((Date.today+1).strftime('%F'))
  end
end