require "rails_helper"

RSpec.describe "All Recent Rounds", :vcr do
  it "get request for /rounds/recent_rounds (info: 3 most recents public rounds with votes, vote content, placement in round)" do
    load_test_data
    get "/api/v0/rounds/recent_rounds"

    expect(response).to be_successful

    json_response = JSON.parse(response.body)

    expect(json_response["data"].length).to eq(4)
  end
end
