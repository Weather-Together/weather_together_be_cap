class Vote < ApplicationRecord
  before_save do
    self.target_weather_stats = round.target_weather_stats
  end
  belongs_to :user
  belongs_to :round

  enum status: { unprocessed: 0, processed: 1 }
  
  def process
    unless self.score
      wf = WeatherFacade.new
      new_lat = lat
      new_lon = lon
      data = {:error=>{:code=>1006, :message=>"No matching location found."}}
      while data[:error]
        data = wf.weather_data(new_lat, new_lon, Date.yesterday.strftime('%F'))
        new_lat = rand(-90.000...90.000)
        new_lon = rand(-180.000...180.000)
      end
      new_score = calculate_score(data)
      update(status: :processed, score: new_score, weather_stats: data)
    end
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