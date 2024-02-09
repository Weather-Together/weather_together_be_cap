
require 'rails_helper'

RSpec.describe "API::V0::Users::Games", :vcr do
  describe "GET /api/v0/users/:id/games" do
    before(:each) do 
      load_test_data 
    end

    describe "when the user exists" do
      before { get "/api/v0/users/#{@user1.id}/games" } 

      it "returns a success response" do
        expect(response).to have_http_status(:success)
      end

      it "returns the user's games" do
        expect(JSON.parse(response.body)).not_to be_empty
      end
    end

    describe "when the user does not exist" do
      before { get "/api/v0/users/0/games" }

      it "returns an error message" do
        json_response = JSON.parse(response.body)
        expect(json_response["errors"].first["detail"]).to eq("Couldn't find User with 'id'=0")
      end
    end
  end
end