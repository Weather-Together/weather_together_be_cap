class VoteSerializer
  include JSONAPI::Serializer
  attributes :lat,
    :lon,
    :score,
    :status,
    :round_id,
    :user_id,
    :username,
    :location_name,
    :region,
    :country,
    :maxtemp_f,
    :mintemp_f,
    :avgtemp_f,
    :maxwind_mph,
    :totalprecip_in,
    :avghumidity,
    :daily_chance_of_rain,
    :daily_chance_of_snow

  attribute :round_id do |vote|
    vote.round.id
  end

  attribute :user_id do |vote|
    vote.user.id
  end
  attribute :username do |vote|
    vote.user.username
  end
end
