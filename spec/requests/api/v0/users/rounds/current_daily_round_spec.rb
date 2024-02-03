require 'rails_helper'

describe "users/rounds API" do
  it "current_community_round", :vcr do
    test_data

    get "/api/v0/users/#{@user1.id}/rounds/current_daily_round"
    expect(response).to be_successful
    expect(response.status).to eq(200)

    round = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(round[:id].to_i).to be_an Integer
    expect(round[:id].to_i).to eq(@round12.id)
    expect(round[:type]).to eq("bulkround")
    expect(round[:attributes][:status]).to eq("open")
    expect(round[:attributes][:close_date]).to eq(@round12.close_date)
    expect(round[:attributes][:number_of_votes]).to eq(10)

    expect(round[:attributes][:location_name]).to eq(@round12.location_name)
    expect(round[:attributes][:maxtemp_f]).to eq(@round12.maxtemp_f)
    expect(round[:attributes][:avghumidity]).to eq(@round12.avghumidity)
  end
end