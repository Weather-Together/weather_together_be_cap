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
      test_data
    end
    it "give current_competitive_round", :vcr do
      results = Game.current_competitive_round
      expect(results).to eq(@round6)
      expect(results).not_to eq(@round3)
      expect(results).not_to eq(@round4)
      expect(results).not_to eq(@round1)
    end
  end
end
