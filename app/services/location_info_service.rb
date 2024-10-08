class LocationInfoService
  def self.conn
    Faraday.new(url: "https://seal-app-7kdpa.ondigitalocean.app/")
  end

  def self.get_details(lat, lon)
    image_api_key = Rails.application.credentials.image_api[:key]
    geo_api_key = Rails.application.credentials.geocoding_api[:key]
    response = conn.get("api/v0/information?lat=#{lat}&lon=#{lon}&image_api_key=#{image_api_key}&geo_api_key=#{geo_api_key}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
