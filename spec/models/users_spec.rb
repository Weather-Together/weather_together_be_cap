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
  end

   before(:each) do
    # Load test data
    load_query_test_data
  end

  describe "#daily_game_count" do
    it "returns the correct count of daily games" do
      user = User.find_by(username: 'user1')
      expect(user.daily_game_count).to eq(4)
    end
  end

  describe "#average_score_in_daily_games" do
    it "returns the correct average score in daily games" do
      user = User.find_by(username: 'user1')
      expect(user.average_score_in_daily_games).to be_a(Float)
    end
  end

  describe "#date_and_score_of_best_daily_score" do
    it "returns the correct date and score of the best daily score" do
      user = User.find_by(username: 'user1')
     lowest_score_vote = user.date_and_score_of_best_daily_score

      expect(lowest_score_vote[:date]).to be_a(String)
      expect(lowest_score_vote[:score]).to be_a(Float)
    end
  end

  describe "#grade_book_daily_round" do
    it "returns the correct grade book for daily rounds" do
      user = User.find_by(username: 'user1')
      result = user.grade_book_daily_round
      expect(result).to be_a(Hash)
      expect(result.keys).to match_array(['0.00-500.00', '500.01-1000.00', '1000.01-2000.00', '2000.01-5000.00', '5000.01+'])
    end
  end

  describe ".top_5_competitive_users" do
    it "returns the top 5 competitive users with average scores" do
      result = User.top_5_competitive_users
      expect(result).to be_an(Array)
      expect(result.length).to eq(2)
      expect(result[0]).to have_key(:username)
      expect(result[0]).to have_key(:score)
    end
  end

  describe "#user_competitive_rank" do
    it "returns the correct competitive rank for the user" do
      user = User.find_by(username: 'user1')
      expect(user.user_competitive_rank).to be_an(Integer)
    end
  end

  describe "#competitive_game_count" do
    it "returns the correct count of competitive games" do
      user = User.find_by(username: 'user1')
      expect(user.competitive_game_count).to eq(4)
    end
  end

  describe "#average_score_in_competitive_games" do
    it "returns the correct average score in competitive games" do
      user = User.find_by(username: 'user1')
      expect(user.average_score_in_competitive_games).to be_a(Float).or be_nil
    end
  end

  describe "#top_three_competitive_rounds_by_score" do
    it "returns the top three competitive rounds by score" do
      user = User.find_by(username: 'user1')
      result = user.top_three_competitive_rounds_by_score

      expect(result).to be_an(ActiveRecord::Relation)
      expect(result.count).to eq(3)
    end
  end

  describe "#last_three_competitive_games_rank" do
    it "returns the rank of the user in the last three competitive games" do
      user = User.find_by(username: 'user1')
      result = user.last_three_competitive_games_rank
      
      expect(result).to be_an(Array)
      expect(result.length).to eq(3)
      expect(result[0]).to have_key(:round_id)
      expect(result[0]).to have_key(:user_rank)
    end
  end

  describe "#top_three_finishes_competitive" do
    it "returns the top three finishes in competitive games" do
      user = User.find_by(username: 'user1')
      result = user.top_three_finishes_competitive
      expect(result).to be_an(Array)
      expect(result.count).to eq(3)
    end
  end
end