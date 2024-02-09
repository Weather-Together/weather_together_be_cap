class LocationInfoService
  

  def self.conn
    Faraday.new(url: "https://seahorse-app-ybzev.ondigitalocean.app/")
  end

  def self.get_details(lat, lon)
    response = conn.get("api/v0/information?lat=#{lat}&lon=#{lon}")
    hash = JSON.parse(response.body, symbolize_names: true)
    hash
  end
end
