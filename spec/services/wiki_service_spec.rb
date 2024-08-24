require "rails_helper"

RSpec.describe "Wiki API call", :vcr do
  it "#conn, returns a Faraday object" do
    ws = WikiService.new

    expect(ws.conn).to be_a(Faraday::Connection)
  end

  it "#parse_wikipage(titles), gets wiki article and url both when page exists and does not exists", :vcr do
    ws = WikiService.new
    data = ws.parse_wikipage("Denver")
    data_nopage = ws.parse_wikipage("Nnsense112233")

    expect(data).to be_a(Hash)
    expect(data[:articlenum]).to eq(8522)
    expect(data[:url]).to eq("https://en.wikipedia.org/wiki/Denver")
    expect(data_nopage[:articlenum]).to eq(-1)
    expect(data_nopage[:url]).to eq("https://en.wikipedia.org/wiki/Nnsense112233")
  end

  it "#valid_article?(wikipage_data), returns true if articlenum > 0", :vcr do
    ws = WikiService.new
    data = ws.parse_wikipage("Denver")
    data_nopage = ws.parse_wikipage("Nnsense112233")

    expect(ws.valid_article?(data)).to be(true)
    expect(ws.valid_article?(data_nopage)).to be(false)
  end

  it "#get_link(location), returns a wiki link from location hash, with increasing specificity, locality", :vcr do
    load_location_coordinates

    location_locality = GeocodingService.new.get_location(lat3, @lon3)
    ws = WikiService.new
    data = ws.get_link(location_locality)

    expect(data).to be_a(Hash)
    expect(data[:url]).to eq("https://en.wikipedia.org/wiki/Denver")
    expect(data[:specificity]).to eq("locality")
  end

  it "#get_link(location), returns a wiki link from location hash, with increasing specificity, state", :vcr do
    location_state =  {
      Locationlat: "39.74",
      Locationlon: "-104.99",
      locality: nil,
      state: "Colorado",
      region: "Midwest",
      country: "United States"
    }
    ws = WikiService.new
    data = ws.get_link(location_state)

    expect(data).to be_a(Hash)
    expect(data[:url]).to eq("https://en.wikipedia.org/wiki/Colorado")
    expect(data[:specificity]).to eq("state")
  end

  it "#get_link(location), returns a wiki link from location hash, with increasing specificity, region", :vcr do
    location_state =  {
      Locationlat: "39.74",
      Locationlon: "-104.99",
      locality: nil,
      state: nil,
      region: "Midwest",
      country: "United States"
    }
    ws = WikiService.new
    data = ws.get_link(location_state)

    expect(data).to be_a(Hash)
    expect(data[:url]).to eq("https://en.wikipedia.org/wiki/Midwest")
    expect(data[:specificity]).to eq("region")
  end

  it "#get_link(location), returns a wiki link from location hash, with increasing specificity, country", :vcr do
    location_state =  {
      Locationlat: "39.74",
      Locationlon: "-104.99",
      locality: nil,
      state: nil,
      region: nil,
      country: "United States"
    }
    ws = WikiService.new
    data = ws.get_link(location_state)

    expect(data).to be_a(Hash)
    expect(data[:url]).to eq("https://en.wikipedia.org/wiki/United_States")
    expect(data[:specificity]).to eq("region")
  end
end
