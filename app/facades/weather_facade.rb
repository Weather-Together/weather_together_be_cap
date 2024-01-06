class WeatherFacade

  def weather_data(lat, lon)
    ws = WeatherService.new
    data_hash = ws.get_details(lat, lon, Date.today.strftime("%F"))
  end

end

