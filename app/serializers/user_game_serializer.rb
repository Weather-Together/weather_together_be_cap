class UserGameSerializer 
  include JSONAPI::Serializer
  attributes :id,
             :user_id, 
             :game_id, 
             :invitation

  attribute :game_name do |object|
    object.game&.name
  end
end