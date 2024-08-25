require "rails_helper"

RSpec.describe "Image API call", :vcr do
  it "#conn, returns a Faraday object" do
    is = ImageService.new

    expect(is.conn).to be_a(Faraday::Connection)
  end

  xit "#get_images(search_term), returns image url from location at specific location", :vcr do
  # location_state =  {
  #   Locationlat: "39.74",
  #   Locationlon: "-104.99",
  #   locality: "Denver",
  #   state: nil,
  #   region: nil,
  #   country: "United States"
  # }

  #   is = ImageService.new
  #   data = is.get_images(location_state)
  #   expect(data).to be_a(Hash)
    facade = LocationInfoFacade.new.combine_location_information("39.74", "-104.99")
  end
end
