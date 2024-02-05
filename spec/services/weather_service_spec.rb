require "rails_helper"

RSpec.describe "API call", :vcr do
  it "gets weather data for a location", :vcr do
    load_location_coordinates
    ws = WeatherService.new
    data = ws.get_details(@lat1, @lon1, @date)

    expect(data).to be_a(Hash)
    expect(data[:location]).to be_a(Hash)
    expect(data[:location]).to have_key(:lat)
    expect(data[:location][:lat]).to eq(-15.74)
    expect(data[:location]).to have_key(:lon)
    expect(data[:location][:lon]).to eq(-54.34)
    expect(data[:location]).to have_key(:name)
    expect(data[:location][:name]).to eq("Alto Coite")
    expect(data[:location]).to have_key(:region)
    expect(data[:location][:region]).to eq("Mato Grosso")

    expect(data[:weather_data]).to be_a(Hash)
    expect(data[:weather_data]).to have_key(:maxtemp_f)
    expect(data[:weather_data][:maxtemp_f]).to be_a(Float)
    expect(data[:weather_data]).to have_key(:mintemp_f)
    expect(data[:weather_data][:mintemp_f]).to be_a(Float)
    expect(data[:weather_data]).to have_key(:maxwind_mph)
    expect(data[:weather_data][:maxwind_mph]).to be_a(Float)
    expect(data[:weather_data]).to have_key(:avghumidity)
    expect(data[:weather_data][:avghumidity]).to be_a(Integer)
    expect(data[:weather_data]).to have_key(:totalprecip_in)
    expect(data[:weather_data][:totalprecip_in]).to be_a(Float)
  end

  it "gets weather data for a second location", :vcr do
    load_location_coordinates
    ws = WeatherService.new
    data = ws.get_details(@lat2, @lon2, @date)

    expect(data).to be_a(Hash)
    expect(data[:location]).to be_a(Hash)
    expect(data[:location]).to have_key(:lat)
    expect(data[:location][:lat]).to eq(36.53)
    expect(data[:location]).to have_key(:lon)
    expect(data[:location][:lon]).to eq(-116.93)
    expect(data[:location]).to have_key(:name)
    expect(data[:location][:name]).to eq("Beatty Junction")
    expect(data[:location]).to have_key(:region)
    expect(data[:location][:region]).to eq("California")

    expect(data[:weather_data]).to be_a(Hash)
    expect(data[:weather_data]).to have_key(:maxtemp_f)
    expect(data[:weather_data][:maxtemp_f]).to be_a(Float)
    expect(data[:weather_data]).to have_key(:mintemp_f)
    expect(data[:weather_data][:mintemp_f]).to be_a(Float)
    expect(data[:weather_data]).to have_key(:maxwind_mph)
    expect(data[:weather_data][:maxwind_mph]).to be_a(Float)
    expect(data[:weather_data]).to have_key(:avghumidity)
    expect(data[:weather_data][:avghumidity]).to be_a(Integer)
    expect(data[:weather_data]).to have_key(:totalprecip_in)
    expect(data[:weather_data][:totalprecip_in]).to be_a(Float)
  end
end
