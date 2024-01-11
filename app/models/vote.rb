class Vote < ApplicationRecord
  before_save do
    self.target_weather_stats = round.target_weather_stats
  end
  belongs_to :user
  belongs_to :round

  enum status: { unprocessed: 0, processed: 1 }
  
  def process
    weather_data = WeatherFacade.new.weather_data(lat, lon, Date.yesterday.strftime('%F'))
    score = calculate_score(weather_data)
    update(status: :processed, score: score, weather_stats: weather_data)
  end

  def calculate_score(weather_data)
    target = JSON.parse(target_weather_stats, symbolize_names: true)[:weather_data]
    guess = JSON.parse(weather_data, symbolize_names: true)[:weather_data]
    high_temp_diff = (target[:maxtemp_f]-guess[:maxtemp_f])**2
    low_temp_diff = (target[:mintemp_f]-guess[:mintemp_f])**2
    humidity_diff = (target[:avghumidity]-guess[:avghumidity])**2
    wind_diff = (target[:maxwind_mph]-guess[:maxwind_mph])**2
    rain_diff = (target[:daily_chance_of_rain]-guess[:daily_chance_of_rain])**2
    snow_diff = (target[:daily_chance_of_snow]-guess[:daily_chance_of_snow])**2
    high_temp_diff + low_temp_diff + humidity_diff + wind_diff + rain_diff + snow_diff
  end
end