require "rails_helper"

RSpec.describe "Geocoding API call", :vcr do
  # "High" Specificity Keys from API (general high to low order): village, town, city_district, city, county
    # Calling it a locality 
  it "gets location data from lat lon, no region", :vcr do
    load_location_coordinates
    gs = GeocodingService.new
    data = gs.get_details(@lat3, @lon3)
    
    expect(data).to be_a(Hash)
    expect(data[:Locationlat]).to eq("39.74")
    expect(data[:Locationlon]).to eq("-104.99")
    expect(data[:locality]).to eq("Denver")
    expect(data[:state]).to eq("Colorado")
    expect(data[:region]).to eq(nil)
    expect(data[:country]).to eq("United States")
  end

  it "gets location data from lat lon, multiple locality", :vcr do
    load_location_coordinates
    gs = GeocodingService.new
    data = gs.get_details(@lat4, @lon4)

    expect(data).to be_a(Hash)
    expect(data[:Locationlat]).to eq("39.95")
    expect(data[:Locationlon]).to eq("-105.82")
    expect(data[:locality]).to eq("Fraser")
    expect(data[:state]).to eq("Colorado")
    expect(data[:region]).to eq(nil)
    expect(data[:country]).to eq("United States")
  end

  it "gets location data from lat lon, another with multiple locality", :vcr do
    load_location_coordinates
    gs = GeocodingService.new
    data = gs.get_details(@lat1, @lon1)

    expect(data).to be_a(Hash)
    expect(data[:Locationlat]).to eq("-15.74")
    expect(data[:Locationlon]).to eq("-54.34")
    expect(data[:locality]).to eq("Alto Coité")
    expect(data[:state]).to eq("Mato Grosso")
    expect(data[:region]).to eq("Central-West Region")
    expect(data[:country]).to eq("Brazil")
  end

  it "gets location data from lat lon, few address keys", :vcr do
    load_location_coordinates
    gs = GeocodingService.new
    data = gs.get_details(@lat14, @lon14)

    expect(data).to be_a(Hash)
    expect(data[:Locationlat]).to eq("14.24")
    expect(data[:Locationlon]).to eq("40.92")
    expect(data[:locality]).to eq(nil)
    expect(data[:state]).to eq("Southern Red Sea Region")
    expect(data[:region]).to eq(nil)
    expect(data[:country]).to eq("Eritrea")
  end
end
