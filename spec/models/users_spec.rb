require "rails_helper"

RSpec.describe User, type: :model do
  
  describe "relationships" do
    it { should have_many(:votes) }
    it { should have_many(:user_games) }
  end

  # describe "validations" do
  #   it { should validate_presence_of(:title) }
  #   it { should validate_presence_of(:runtime) }

  # end
end