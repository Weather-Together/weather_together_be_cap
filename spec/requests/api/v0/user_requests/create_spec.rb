require "rails_helper"

RSpec.describe "User Recent Rounds" do
  it "goes to post request", :vcr do
    test_data
    new_user = {
      username: "mbkuhl",
      email: "kuhlmmb@gmail.com",
      password: "ThisIsAGoodPassword1!",
      password_confirmation: "ThisIsAGoodPassword1!"
    }

    post "/api/v0/users", params: new_user.to_json, headers: {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
    expect(response).to be_successful
    expect(response.status).to eq(200)
  end

  it "goes to post request sad path", :vcr do
    test_data
    new_user = {
      "username": "username1",
      "email": "user1@gmail.com",
      "password": "ThisIsAGoodPassword!",
      "password_confirmation": "ThisIsAGoodPassword1!"
    }

    post "/api/v0/users", params: new_user.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to_not be_successful
    expect(response.status).to eq(422)
    message = JSON.parse(response.body, symbolize_names: true)
  end
end
