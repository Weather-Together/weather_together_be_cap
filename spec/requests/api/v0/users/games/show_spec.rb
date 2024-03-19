require "rails_helper"

describe "respond to invite" do
  it "can succesfully accept invite", :vcr do
    public_games
    
    @user1 = User.create!(username: "username1", email: "user1@gmail.com", password: "password1")
    @user2 = User.create!(username: "username2", email: "user2@gmail.com", password: "password1")
    @user3 = User.create!(username: "username3", email: "user3@gmail.com", password: "password1")

    new_game = {
                name: "Storm Chasers",
                length_in_days: 145,
                guess_lead_time: 12,
                player_cap: 12,
                invitees: ["user2@gmail.com", "user3@gmail.com"]
               }
    post "/api/v0/users/#{@user1.id}/games", params: new_game.to_json, headers: {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

    game_id = game = JSON.parse(response.body, symbolize_names: true)[:data][:id]

    get "/api/v0/users/#{@user1.id}/games/#{game_id}"

    expect(response).to be_successful
    expect(response.status).to eq(200)

    game = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(game[:id].to_i).to be_an Integer
    expect(game[:id].to_i).to_not eq(0)
    expect(game[:type]).to eq("game")
    expect(game[:attributes][:name]).to eq("Storm Chasers")
    expect(game[:attributes][:game_type]).to eq("custom")
    expect(game[:attributes][:length_in_days]).to eq(145)
    expect(game[:attributes][:guess_lead_time]).to eq(12)
    expect(game[:attributes][:player_cap]).to eq(12)
    expect(game[:attributes][:status]).to eq("open")
    expect(game[:attributes][:start_date]).to eq((Date.today + 1).strftime("%F"))
    expect(game[:attributes][:close_date]).to eq((Date.today + 146).strftime("%F"))
    expect(game[:attributes][:users].count).to eq(3)
    expect(game[:attributes][:users].first[:attributes][:username]).to eq(@user1.username)
  end

    it "can succesfully accept invite", :vcr do
    public_games

    @user1 = User.create!(username: "username1", email: "user1@gmail.com", password: "password1")
    @user2 = User.create!(username: "username2", email: "user2@gmail.com", password: "password1")
    @user3 = User.create!(username: "username3", email: "user3@gmail.com", password: "password1")

    new_game = {
                name: "Storm Chasers",
                length_in_days: 145,
                guess_lead_time: 12,
                player_cap: 12,
                invitees: ["user2@gmail.com", "user3@gmail.com"]
               }
    post "/api/v0/users/#{@user1.id}/games", params: new_game.to_json, headers: {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}

    game_id = JSON.parse(response.body, symbolize_names: true)[:data][:id]

    get "/api/v0/users/#{@user2.id}/games/#{game_id}"

    expect(response).to_not be_successful
    expect(response.status).to eq(401)

    message = JSON.parse(response.body, symbolize_names: true)[:data]

    expect(message[:error]).to eq("User must accept invitation to view game")
  end

  it "can show user data", :vcr  do
    test_data
    @round.close_round
    expect(@round.reload.status).to eq("closed")
    @round.process_round
    expect(@round.reload.status).to eq("processed")

    game_id = @round.game.id

    expect(@user1.rank_in_game(game_id)).to eq(@user1.rank_in_game(game_id))
    expect(@user1.total_overall_score_private_games(game_id)).to be_within(100).of(@user1.total_overall_score_private_games(game_id))
    expect(@user1.rounds_won_private_games(game_id)).to eq(@user1.rounds_won_private_games(game_id))

    expect(@user2.rank_in_game(game_id)).to eq(@user2.rank_in_game(game_id))
    expect(@user2.total_overall_score_private_games(game_id)).to be_within(100).of(@user2.total_overall_score_private_games(game_id))
    expect(@user2.rounds_won_private_games(game_id)).to eq(@user2.rounds_won_private_games(game_id))

    expect(@user3.rank_in_game(game_id)).to eq(@user3.rank_in_game(game_id))
    expect(@user3.total_overall_score_private_games(game_id)).to be_within(100).of(@user3.total_overall_score_private_games(game_id))
    expect(@user3.rounds_won_private_games(game_id)).to eq(@user3.rounds_won_private_games(game_id))

    expect(@user4.rank_in_game(game_id)).to eq(@user4.rank_in_game(game_id))
    expect(@user4.total_overall_score_private_games(game_id)).to be_within(100).of(@user4.total_overall_score_private_games(game_id))
    expect(@user4.rounds_won_private_games(game_id)).to eq(@user4.rounds_won_private_games(game_id))

    expect(@user5.rank_in_game(game_id)).to eq(@user5.rank_in_game(game_id))
    expect(@user5.total_overall_score_private_games(game_id)).to be_within(100).of(@user5.total_overall_score_private_games(game_id))
    expect(@user5.rounds_won_private_games(game_id)).to eq(@user5.rounds_won_private_games(game_id))

    expect(@user6.rank_in_game(game_id)).to eq(@user6.rank_in_game(game_id))
    expect(@user6.total_overall_score_private_games(game_id)).to be_within(100).of(@user6.total_overall_score_private_games(game_id))
    expect(@user6.rounds_won_private_games(game_id)).to eq(@user6.rounds_won_private_games(game_id))

    expect(@user7.rank_in_game(game_id)).to eq(@user7.rank_in_game(game_id))
    expect(@user7.total_overall_score_private_games(game_id)).to be_within(100).of(@user7.total_overall_score_private_games(game_id))
    expect(@user7.rounds_won_private_games(game_id)).to eq(@user7.rounds_won_private_games(game_id))

    expect(@user8.rank_in_game(game_id)).to eq(@user8.rank_in_game(game_id))
    expect(@user8.total_overall_score_private_games(game_id)).to be_within(100).of(@user8.total_overall_score_private_games(game_id))
    expect(@user8.rounds_won_private_games(game_id)).to eq(@user8.rounds_won_private_games(game_id))

    expect(@user9.rank_in_game(game_id)).to eq(@user9.rank_in_game(game_id))
    expect(@user9.total_overall_score_private_games(game_id)).to be_within(100).of(@user9.total_overall_score_private_games(game_id))
    expect(@user9.rounds_won_private_games(game_id)).to eq(@user9.rounds_won_private_games(game_id))

    expect(@user10.rank_in_game(game_id)).to eq(@user10.rank_in_game(game_id))
    expect(@user10.total_overall_score_private_games(game_id)).to be_within(100).of(@user10.total_overall_score_private_games(game_id))
    expect(@user10.rounds_won_private_games(game_id)).to eq(@user10.rounds_won_private_games(game_id))
  end
end
