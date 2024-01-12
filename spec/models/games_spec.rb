require "rails_helper"

RSpec.describe Game, type: :model do
  
  describe "relationships" do
    it { should have_many(:user_games) }
    it { should have_many(:rounds) }
    it { should have_many(:users).through(:user_games) }
  end

  describe "validations" do
    # it { should validate_presence_of(:game_type) }
    # it { should validate_presence_of(:length_in_days) }
    # it { should validate_presence_of(:guess_lead_time) }
    # it { should validate_presence_of(:player_cap) }
    # it { should validate_presence_of(:status) }
    # it { should validate_presence_of(:results) }
  end

  describe "methods" do
    before(:each) do
      load_test_data
    end
    it "give current_community_round" do
      
      results = Game.current_community_round
      # binding.pry
      expect(results).to eq(@round4)
      expect(results).not_to eq(@round3)
      expect(results).not_to eq(@round2)
      expect(results).not_to eq(@round1)
    end

  end
end