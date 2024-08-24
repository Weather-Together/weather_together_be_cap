require "rails_helper"

RSpec.describe "Wiki API call", :vcr do
  it "#conn, returns a Faraday object" do
    ws = WikiService.new

    expect(ws.conn).to be_a(Faraday::Connection)
  end

  it "#get_wikipage(titles), gets wiki article and url both when page exists and does not exists", :vcr do
    ws = WikiService.new
    data = ws.get_wikipage("Denver")
    data_nopage = ws.get_wikipage("Nnsense112233")

    expect(data).to be_a(Hash)
    expect(data[:articlenum]).to eq(8522)
    expect(data[:url]).to eq("https://en.wikipedia.org/wiki/Denver")
    expect(data_nopage[:articlenum]).to eq(-1)
    expect(data_nopage[:url]).to eq("https://en.wikipedia.org/wiki/Nnsense112233")
  end

  xit "#get_link(location), returns a wiki link", :vcr do
    load_location_coordinates

    location = GeocodingService.new.get_location(lat3, @lon3)
    ws = WikiService.new
    data = ws.get_link(location)

    expect(data).to be_a(Hash)
    expect(data[:url]).to eq("https://en.wikipedia.org/wiki/Denver")
    expect(data[:specificity]).to eq("locality")
  end

  xit "#returns_article(location_info), determines article number", :vcr do
    load_location_coordinates

    location = GeocodingService.new.get_location(lat3, @lon3)
    ws = WikiService.new
    data = ws.get_link(location)

    expect(data).to be_a(Hash)
    expect(data[:url]).to eq("https://en.wikipedia.org/wiki/Denver")
    expect(data[:specificity]).to eq("locality")
  end


end
