class VoteSerializer
  include JSONAPI::Serializer
  attributes  :target_weather_stats,
              :lat,
              :lon,
              :weather_stats,
              :score,
              :status
  belongs_to :round

end