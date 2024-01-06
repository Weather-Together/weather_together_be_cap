require "rails_helper"

RSpec.describe User, type: :model do
  
  describe "relationships" do
    it { should have_many(:votes) }
    it { should have_many(:user_games) }
    it { should have_many(:games).through(:user_games) }
    it { should have_many(:rounds).through(:games) }
  end

  describe "validations" do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:verified) }

  end
end