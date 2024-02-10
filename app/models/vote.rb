class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :round
  has_many :game, through: :round
  
  enum status: { unprocessed: 0, processed: 1 }

  def process
    unless score
      wf = WeatherFacade.new
      new_lat = lat
      new_lon = lon
      data = {error: {code: 1006, message: "No matching location found."}}
      while data[:error]
        data = wf.weather_data(new_lat, new_lon, Date.yesterday.strftime("%F"))
        new_lat = rand(-90.000...90.000)
        new_lon = rand(-180.000...180.000)
      end
      new_score = calculate_score(data)
      update(status: :processed,
            score: new_score,
            location_name: data[:location][:name],
            region: data[:location][:region],
            country: data[:location][:country],
            lat: data[:location][:lat],
            lon: data[:location][:lon],
            maxtemp_f: data[:weather_data][:maxtemp_f],
            mintemp_f: data[:weather_data][:mintemp_f],
            maxwind_mph: data[:weather_data][:maxwind_mph],
            totalprecip_in: data[:weather_data][:totalprecip_in],
            avgvis_miles: data[:weather_data][:avgvis_miles],
            avghumidity: data[:weather_data][:avghumidity],
            daily_chance_of_rain: data[:weather_data][:daily_chance_of_rain],
            daily_chance_of_snow: data[:weather_data][:daily_chance_of_snow])
    end
  end

  def calculate_score(weather_data)
    guess = weather_data[:weather_data]
    high_temp_diff = (round.maxtemp_f - guess[:maxtemp_f])**2
    low_temp_diff = (round.mintemp_f - guess[:mintemp_f])**2
    humidity_diff = (round.avghumidity - guess[:avghumidity])**2
    wind_diff = (round.maxwind_mph - guess[:maxwind_mph])**2
    rain_diff = (round.daily_chance_of_rain - guess[:daily_chance_of_rain])**2
    snow_diff = (round.daily_chance_of_snow - guess[:daily_chance_of_snow])**2
    high_temp_diff + low_temp_diff + humidity_diff + wind_diff + rain_diff + snow_diff
  end

  def get_location_information
    info = LocationInfoService.get_details(lat, lon) #need to update vote with return once we start receiving correct data
    require 'pry'; binding.pry
    update!(image: info[:images].first, wiki: info[:wiki])
  end
end
