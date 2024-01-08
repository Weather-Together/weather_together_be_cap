require 'rails_helper'

RSpec.describe "User Recent Rounds" do
  before :each do
    load_test_data
  end
  
  it "get request for /users/:user_id/recent_rounds (info: 3 most recents public rounds with votes, vote content, placement in round)" do
    get "/api/v0/users"

    expect(response).to be_successful
    
    json_response = JSON.parse(response.body)
    binding.pry
    expect(json_response['data'].length).to eq(10)
  end
end