require 'rails_helper'

RSpec.describe "User find_or_create" do
  it "Can create an account with email through users/oauth" do
    new_acct = {
      "email": "test@gmail.com",
    }

    post "/api/v0/users/oauth_login", params: new_acct.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }

    expect(response.status).to eq(200)
    message = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(message[:attributes][:email]).to eq("test@gmail.com")
    expect(message[:id]).to_not be nil
  end

  it "Can get that same user_id from the same email" do
    new_acct = {
      "email": "test@gmail.com",
    }

    post "/api/v0/users/oauth_login", params: new_acct.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    
    message = JSON.parse(response.body, symbolize_names: true)[:data]
    user_id = message[:id]

    post "/api/v0/users/oauth_login", params: new_acct.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    
    expect(response.status).to eq(200)
    message = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(message[:attributes][:email]).to eq("test@gmail.com")
    expect(message[:id]).to eq(user_id)
  end
end