require "rails_helper"

RSpec.describe "User Update Profile Endpoint" do
  describe "happy path" do
    it "supports with POST request for User Update", :vcr do
      test_data

      user1 = @user1
require 'pry'; binding.pry
      patch "/api/v0/users/#{user1.id}", params: {}, headers: {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(response_data[:type]).to eq("user")
      expect(response_data[:id]).to be_a(String)

      expect(response_data[:attributes][:email]).to eq("user1@gmail.com")
      expect(response_data[:attributes][:username]).to eq("username1")
    end
  end
end