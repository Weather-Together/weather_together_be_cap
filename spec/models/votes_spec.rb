require "rails_helper"

RSpec.describe Vote, type: :model do
  
  describe "relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:round) }
  end

  describe "calculate_score" do
    it "can calculate a score", :vcr do
      test_data
      vote = Vote.all.first
      expect(vote.weather_stats).to be nil
      expect(vote.score).to be nil
      weather_data = WeatherFacade.new.weather_data(vote.lat, vote.lon, Date.yesterday.strftime('%F'))
      score = vote.calculate_score(weather_data)
      expect(score>0).to be true
    end
  end

  describe "process" do
    it "can update vote", :vcr do
      test_data
      vote = Vote.all.first
      vote_id = vote.id
      expect(vote.weather_stats).to be nil
      expect(vote.score).to be nil
      expect(vote.unprocessed?).to be true
      expect(vote.processed?).to be false
      vote.process

      vote = Vote.find(vote_id)
      expect(vote.unprocessed?).to be false
      expect(vote.processed?).to be true
      expect(vote.weather_stats).to be_a(String)
      expect(JSON.parse(vote.weather_stats, symbolize_names: true)).to be_a(Hash)
      expect(vote.score>0).to be true
    end
  end
  
end