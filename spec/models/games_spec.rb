require "rails_helper"

RSpec.describe Game, type: :model do
  
  describe "relationships" do
    it { should have_many(:user_games) }
    it { should have_many(:rounds) }
  end

  # describe "validations" do
  #   it { should validate_presence_of(:title) }
  #   it { should validate_presence_of(:runtime) }

  # end
end