require "rails_helper"

RSpec.describe Round, type: :model do
  
  describe "relationships" do
    it { should have_many(:votes) }
    it { should belong_to(:game) }
    it { should have_many(:users).through(:votes) }
  end

  describe "generate_target_data" do
    #this test makes several API calls and cannot use VCR. Only enable if specifically troubleshooting this test
    xit "can generate a set of weather data for a random point on land" do
      VCR.turn_off!
      WebMock.allow_net_connect!
      Round.generate_target_data
      VCR.turn_on!
      WebMock.disable_net_connect!
    end
  end
end