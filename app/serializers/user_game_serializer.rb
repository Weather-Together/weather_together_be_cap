class UserGameSerializer 
  include JSONAPI::Serializer
  attributes :id,
             :user_id, 
             :game_id, 
             :invitation

  attribute :game_name do |object|
    object.game&.name
  end

  attribute :player_count do |object|
    object.game&.users.count
  end

  attribute :rounds do |object|
    "#{object.game&.rounds.count}/#{object.game&.length_in_days}"
  end
end