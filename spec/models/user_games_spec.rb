require "rails_helper"

RSpec.describe UserGame, type: :model do
  describe "relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:game) }
    it { should have_many(:rounds).through(:game) }
  end

  describe "validations" do
    #   it { should validate_presence_of(:title) }
    #   it { should validate_presence_of(:runtime) }
  end
end
