require 'rails_helper'

RSpec.describe "User Recent Rounds" do
  it "goes to post request" do
    test_data
    load_location_coordinates
    new_user = {
      "username": "mbkuhl",
      "email": "kuhlmmb@gmail.com",
      "password": "ThisIsAGoodPassword1!",
      "password_confirmation": "ThisIsAGoodPassword1!"
    }

    post "/api/v0/users", params: new_user.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to be_successful
    expect(response.status).to eq(200)
    require 'pry'; binding.pry
  end
end
