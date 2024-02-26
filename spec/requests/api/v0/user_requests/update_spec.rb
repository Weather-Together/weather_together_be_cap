require "rails_helper"

RSpec.describe "User Update Profile Endpoint" do
  describe "happy path" do
    it "supports with POST request for User Update", :vcr do
      test_data

      user1 = @user1

      expect(user1.username).to eq("username1")

      patch "/api/v0/users/#{user1.id}", params: { user:{ username: "username0" } }.to_json, headers: {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

      expect(response).to be_successful
      expect(response.status).to eq(200)

      response_data = JSON.parse(response.body, symbolize_names: true)[:data]
# require 'pry'; binding.pry
      expect(response_data[:type]).to eq("user")
      expect(response_data[:id]).to be_a(String)

      expect(response_data[:attributes][:email]).to eq("user1@gmail.com")
      expect(response_data[:attributes][:username]).to eq("username0")
    end
  end

  describe "sad path" do
    it "returns an error if user does not exist", :vcr do
      test_data

      user1 = 11

      expect(user1.username).to eq("username1")

      patch "/api/v0/users/#{user1.id}", params: { user:{ username: "username0" } }.to_json, headers: {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      response_data = JSON.parse(response.body, symbolize_names: true)[:errors][0]

      expect(response_data[:detail]).to eq("Couldn't find User with 'id'=11")
    end
  end
end