class BulkroundSerializer
  include JSONAPI::Serializer

  attributes :close_date,
    :number_of_votes,
    :status,
    :game_id,
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
    :daily_chance_of_snow,
    :number_of_votes

  attribute :number_of_votes do |round|
    round.votes.count
  end
end
