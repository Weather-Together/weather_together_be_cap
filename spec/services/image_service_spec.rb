require "rails_helper"

RSpec.describe "Image API call", :vcr do
  it "#conn, returns a Faraday object" do
    is = ImageService.new

    expect(is.conn).to be_a(Faraday::Connection)
  end

  it "#get_image(location), returns image url from location at specific location", :vcr do
    location_state =  {
      url: "39.74",
      specificity: "-104.99",
      locality: nil,
      state: "Colorado",
      region: "Midwest",
      country: "United States"
    }
    ws = WikiService.new
    data = ws.get_link(location_locality)

    expect(data).to be_a(Hash)
    expect(data[:url]).to eq("https://en.wikipedia.org/wiki/Denver")
    expect(data[:specificity]).to eq("locality")
  end
end
