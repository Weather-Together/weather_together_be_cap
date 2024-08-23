class GeocodingService
  def conn
    Faraday.new(url: "https://geocode.maps.co/")
  end

  def get_details(lat, lon)
    response = conn.get("reverse") do |f|
      f.params["lat"] = lat 
      f.params["lon"] = lon
      f.params["api_key"] = Rails.application.credentials.geocoding_api[:key] 
    end
    hash = JSON.parse(response.body, symbolize_names: true)

    if hash[:error]
      hash
    else
      parse_geo_data(hash, lat, lon)
    end
  end

  private
  
  def determine_locality(address)
    address[:village] || address[:town] || address[:city_district] || address[:city] || address[:county]
  end

  def parse_geo_data(hash, lat, lon)
    address = hash[:address]
    locality = determine_locality(address)

    {
      Locationlat: lat,
      Locationlon: lon,
      locality: locality,
      state: address[:state],
      region: address[:region],
      country: address[:country]
    }
  end
end
