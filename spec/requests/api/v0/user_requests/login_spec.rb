require 'rails_helper'

RSpec.describe "User verify_email" do
  it "goes to post request" do
    @user1 = User.create(username: "username1", email: "user1@gmail.com", password: "password1")


    get "/api/v0/users/#{@user1.id}/verify_account/#{@user1.verification_token}"
    
    expect(message).to eq("Successfully verified user")
    @user1 = User.find(@user1.id)

    expect(@user1.verified?).to be true
  end
end