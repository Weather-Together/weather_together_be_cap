require "rails_helper"

RSpec.describe Round, type: :model do

  let(:game) { create(:game) }  # Assuming you have a factory or setup for creating a valid game


  describe "relationships" do
    it { should have_many(:votes) }
    it { should belong_to(:game) }
    it { should have_many(:users).through(:votes) }
  end

  # describe "validations" do
  #   it { should validate_presence_of(:status) }
  #   it { should validate_presence_of(:target_weather_stats) }
  # end

  describe "methods" do
    before(:each) do
      load_test_data
    end

    it "can turnover" do
      expect(@round1.status).to eq("open")
      @round1.close_round
      expect(@round1.reload.status).to eq("closed")
    end

    it "can close_round" do
      expect(@round1.status).to eq("open")
      @round1.close_round
      expect(@round1.reload.status).to eq("closed")
    end


  end
end