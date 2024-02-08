require "rails_helper"

RSpec.describe "User verify_email" do
  it "can verify email with proper token" do
    public_games

    @user1 = User.create(username: "username1", email: "user1@gmail.com", password: "password1")

    expect(@user1.unverified?).to be true
    expect(@user1.verified?).to be false
    expect(@user1.oauth?).to be false
    expect(@user1.verification_token).to_not be nil

    get "/api/v0/users/#{@user1.id}/verify_account/#{@user1.verification_token}"
    expect(response).to be_successful
    expect(response.status).to eq(202)
    message = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(message[:type]).to eq("user")
    @user1 = User.find(@user1.id)

    expect(@user1.verification_token).to be nil
    expect(@user1.verified?).to be true
    expect(@user1.unverified?).to be false
  end

  it "sad path" do
    public_games

    @user1 = User.create(username: "username1", email: "user1@gmail.com", password: "password1")
    @user2 = User.create(username: "username2", email: "user2@gmail.com", password: "password2")

    expect(@user1.unverified?).to be true
    expect(@user1.verified?).to be false
    expect(@user1.oauth?).to be false
    expect(@user1.verification_token).to_not be nil

    get "/api/v0/users/#{@user1.id}/verify_account/#{@user2.verification_token}"
    expect(response).to_not be_successful
    expect(response.status).to eq(422)
    message = JSON.parse(response.body, symbolize_names: true)[:errors].first[:detail]
    expect(message).to eq("Email does not match verification token")

    @user1 = User.find(@user1.id)

    expect(@user1.verification_token).to_not be nil
    expect(@user1.verified?).to be false
    expect(@user1.unverified?).to be true
  end
end
