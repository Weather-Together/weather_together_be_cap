class WeatherFacade
  def weather_data(lat, lon, date)
    ws = WeatherService.new
    data_hash = ws.get_details(lat, lon, date)
  end
end
