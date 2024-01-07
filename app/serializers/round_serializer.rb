class RoundSerializer
  include JSONAPI::Serializer
  attributes  :close_date,
              :number_of_votes,
              :target_weather_stats,
              :status
  belongs_to :game
  has_many :votes
  has_many :users

  attribute :number_of_votes do |round|
    round.votes.count
  end
end