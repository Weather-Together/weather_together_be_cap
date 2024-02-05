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
          username: user.username
        }
      }
    end
  end
end
