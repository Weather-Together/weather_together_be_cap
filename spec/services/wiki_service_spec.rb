require "rails_helper"

RSpec.describe "Wiki API call", :vcr do
  it "#conn, returns a Faraday object" do
    ws = WikiService.new

    expect(ws.conn).to be_a(Faraday::Connection)
  end


end
