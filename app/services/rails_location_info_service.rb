class RailsLocationInfoService
  

  def self.conn
    Faraday.new(url: "https://location-information-ruby-8235c5e6bc6c.herokuapp.com/")
  end

  def self.get_details(lat, lon)
    response = conn.get("api/v0/information?lat=#{lat}&lon=#{lon}")
    hash = JSON.parse(response.body, symbolize_names: true)
    hash
  end
end
