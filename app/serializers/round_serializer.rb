class RoundSerializer
  include JSONAPI::Serializer

  attributes  :close_date,
              :number_of_votes,
              :target_weather_stats,
              :status,
              :game_id,
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
        target_weather_stats: vote.target_weather_stats,
        latitude: vote.lat,
        longitude: vote.lon,
        weather_stats: vote.weather_stats,
        score: vote.score
      }
    end
  end
end