def load_test_data
  # Users
    @user1 = User.create!(username: "username1", email: "user1@gmail.com", password: "password1")
    @user2 = User.create!(username: "username2", email: "user2@gmail.com", password: "password2")

  # Games
    @game1 = Game.create!(length_in_days: 1000000, guess_lead_time: 3, player_cap: 10000, game_type: 0, results: nil)
  
  # Rounds
    @round1 = Round.create!(game_id: @game1.id, target_weather_stats: @data)
    @round2 = Round.create!(game_id: @game1.id, target_weather_stats: @data)

    UserGame.create!(user_id: @user1.id, game_id: @game1.id)
    UserGame.create!(user_id: @user2.id, game_id: @game1.id)
end