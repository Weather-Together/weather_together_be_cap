class RoundSerializer
  include JSONAPI::Serializer

  attributes  :close_date,
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
              :votes
  #belongs_to :game
  # has_many :votes
  # has_many :users

  attribute :number_of_votes do |round|
    round.votes.count
  end

  attribute :votes do |round|
    round.votes.map do |vote|
      {
        vote_id: vote.id,
        user_id: vote.user_id,
        round_id: vote.round_id,
        status: vote.status,
        latitude: vote.lat,
        longitude: vote.lon,
        score: vote.score,
        location_name: vote.location_name,
        region: vote.region,
        country: vote.country
      }
    end
  end
end