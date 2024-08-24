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
        data = wf.weather_data(new_lat, new_lon, (Date.today-1).strftime("%F"))
        new_lat = rand(-90.000...90.000)
        new_lon = rand(-180.000...180.000)
      end
      update(status: :processed,
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
        calculate_score
    end
  end

  def calculate_score
    if maxtemp_f
      high_temp_diff = (round.maxtemp_f &.- maxtemp_f)**2
      low_temp_diff = (round.mintemp_f &.- mintemp_f)**2
      humidity_diff = (round.avghumidity &.- avghumidity)**2
      wind_diff = (round.maxwind_mph &.- maxwind_mph)**2
      rain_diff = (round.totalprecip_in &.- totalprecip_in)**2
      score = high_temp_diff &.+ low_temp_diff &.+ humidity_diff &.+ wind_diff &.+ rain_diff
      update(score: score)
    else
      update(score: 10001)
    end
  end

  def get_location_information
    info = LocationInfoFacade.new.combine_location_information(lat, lon) #need to update vote with return once we start receiving correct data
    update!(image: info[:images], wiki: info[:wiki])
  end
end
