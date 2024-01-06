class WeatherService

  def test
    lat = "39.9450"
    lon = "-105.8172"
    date = "2024-01-01"
    get_details(lat, lon, date)
  end

  def conn
    Faraday.new(url: "http://api.weatherapi.com/v1/")
  end

  def get_details(lat, lon, date)
    response = conn.get("history.json?key=#{Rails.application.credentials.weather_api[:key]}&q=#{lat},#{lon}&dt=#{date}")
    hash = JSON.parse(response.body, symbolize_names: true)
    { 
      location: hash[:location],
      weather_data: hash[:forecast][:forecastday].first[:day]
     }
  end
end