require "rails_helper"

RSpec.describe "User verify_email" do
  it "Can login on a verfied email address" do
    public_games

    @user1 = User.create(username: "username1", email: "user1@gmail.com", password: "password1")

    get "/api/v0/users/#{@user1.id}/verify_account/#{@user1.verification_token}"

    new_login = {
      email: "#{@user1.email}",
      password: "password1"
    }

    post "/api/v0/users/login", params: new_login.to_json, headers: {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

    expect(response.status).to eq(200)
    message = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(message[:attributes][:email]).to eq(@user1.email)
    expect(message[:id]).to eq("#{@user1.id}")
  end

  it "Sad-Path Unverified" do
    public_games

    @user1 = User.create(username: "username1", email: "user1@gmail.com", password: "password1")

    new_login = {
      email: "#{@user1.email}",
      password: "password1"
    }

    post "/api/v0/users/login", params: new_login.to_json, headers: {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

    expect(response.status).to eq(401)
    message = JSON.parse(response.body, symbolize_names: true)[:errors].first[:detail]

    expect(message).to eq("User must verify email")
  end

  it "Sad-Path Wrong Password" do
    public_games

    @user1 = User.create(username: "username1", email: "user1@gmail.com", password: "password1")

    get "/api/v0/users/#{@user1.id}/verify_account/#{@user1.verification_token}"

    new_login = {
      email: "#{@user1.email}",
      password: "password2"
    }

    post "/api/v0/users/login", params: new_login.to_json, headers: {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

    expect(response.status).to eq(401)
    message = JSON.parse(response.body, symbolize_names: true)[:errors].first[:detail]

    expect(message).to eq("Email and/or password are incorrect")
  end
end
