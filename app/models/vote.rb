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
    update(status: :processed, score: score)
  end

  def calculate_score(weather_data)
    high_temp_diff = 0
    low_temp_diff = 0
    humidity_diff = 0
    wind_diff = 0
    precipitation_diff = 0
    high_temp_diff + low_temp_diff + humidity_diff + wind_diff + precipitation
  end
end