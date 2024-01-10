require "rails_helper"

RSpec.describe Vote, type: :model do
  
  describe "relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:round) }
  end

  describe "calculate_score" do
    it "can calculate a score", :vcr do
      
    end
  end
  
end