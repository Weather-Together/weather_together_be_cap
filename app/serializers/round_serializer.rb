class RoundSerializer
  include JSONAPI::Serializer

  attributes :game_id, :status, :target_weather_stats, :close_date
end