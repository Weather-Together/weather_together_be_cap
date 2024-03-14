class GameSerializer
  include JSONAPI::Serializer
  attributes :game_type,
             :name,
             :length_in_days,
             :guess_lead_time,
             :player_cap,
             :status,
             :start_date,
             :close_date,
             :users

  attribute :users do |game|
    game.users.map do |user|
      {
        id: user.id,
        type: "user",
        attributes: {
          email: user.email,
          username: user.username,
          invited: UserGame.find_by(user_id: user.id, game_id: game.id).invitation
        }
      }
    end
  end


  attribute :user_game_stats do |game|
    game.users.map do |user|
      {
        user_id: user.id,
        username: user.username,
        game_id: game.id,
        game_name: game.name,
        rank: user.rank_in_game(game.id),
        total_overall_score_private_games: user.total_overall_score_private_games(game.id),
        rounds_won_private_games: user.rounds_won_private_games(game.id)
      }
    end
  end
end
