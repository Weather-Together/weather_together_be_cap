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

  describe "#daily_game_count" do
    it "returns the count of daily games" do
      user = User.new
      allow(user).to receive(:games).and_return(double("games", where: double("games", count: 5)))
      
      expect(user.daily_game_count).to eq(5)
    end
  end

  describe "#average_score_in_daily_games" do
    it "returns the average score in daily games" do
      user = User.new
      rounds_double = double("rounds", where: double("rounds", average: 80))

      allow(user).to receive(:rounds).and_return(rounds_double)

      expect(user.average_score_in_daily_games).to eq(80)
    end
  end


  describe "#date_and_score_of_highest_daily_score" do
    it "returns the date and score of the highest daily score" do
      user = User.new
      highest_score_round = double("round", created_at: Time.now, score: 100)
      
      allow(user).to receive_message_chain(:rounds, :where, :order, :first).and_return(highest_score_round)

      expect(user.date_and_score_of_highest_daily_score).to eq({ date: Time.now.to_date, score: 100 })
    end

    it "returns nil if there is no highest score round" do
      user = User.new

      allow(user).to receive_message_chain(:rounds, :where, :order, :first).and_return(nil)

      expect(user.date_and_score_of_highest_daily_score).to eq({ date: nil, score: nil })
    end
  end

  describe "#grade_book_daily_round" do
    it "returns the count of daily rounds in different score ranges" do
      user = User.new
      allow(user).to receive(:rounds).and_return(double("rounds", where: double("rounds", where: double("rounds", count: 3))))
      
      expect(user.grade_book_daily_round).to eq({
        '0.00-500.00' => 3,
        '500.01-1000.00' => 3,
        '1000.01-2000.00' => 3,
        '2000.01-5000.00' => 3,
        '5000.01+' => 3
      })
    end
  end

describe "#user_competitive_rank" do
  it "returns the competitive rank of the user" do
    user = User.new
    rounds_double = double("rounds")
    allow(rounds_double).to receive_message_chain(:joins, :where, :group, :select, :to_sql).and_return("subquery")
    allow(rounds_double).to receive(:average).and_return(50)
    allow(user).to receive(:rounds).and_return(rounds_double)
    
    user_double = double("User")
    allow(User).to receive(:joins).and_return(user_double)
    allow(user_double).to receive_message_chain(:where, :count).and_return(5)
    
    expect(user.user_competitive_rank).to eq(6)
  end
end



it "returns the top 5 competitive users" do
  user = User.new
  user_double = double("User")
  allow(User).to receive(:joins).and_return(user_double)
  allow(user_double).to receive_message_chain(:where, :group, :order, :limit, :pluck).and_return([["user1", 100], ["user2", 90], ["user3", 80], ["user4", 70], ["user5", 60]])

  expect(User.top_5_competitive_users).to eq([["user1", 100], ["user2", 90], ["user3", 80], ["user4", 70], ["user5", 60]])
end

  describe "#competitive_game_count" do
    it "returns the count of competitive games" do
      user = User.new
      allow(user).to receive(:games).and_return(double("games", where: double("games", count: 5)))
      
      expect(user.competitive_game_count).to eq(5)
    end
  end

 describe "#average_score_in_competitive_games" do
  it "returns the average score in competitive games" do
    user = User.new

    # Stub the relevant methods and return values
    allow(user).to receive_message_chain(:rounds, :where, :average).and_return(80)

    # Call the actual method
    result = user.average_score_in_competitive_games

    # Make assertions
    expect(result).to eq(80)
  end
end


  describe "#top_three_competitive_rounds_by_score" do
    it "returns the top three competitive rounds by score" do
      user = User.new

      # Stub the relevant methods and return values
      rounds_relation = double("ActiveRecord::Relation")
      allow(user).to receive(:rounds).and_return(rounds_relation)
      allow(rounds_relation).to receive(:where).and_return(rounds_relation)
      allow(rounds_relation).to receive(:order).and_return(rounds_relation)
      allow(rounds_relation).to receive(:limit).and_return(["round1", "round2", "round3"])

      # Call the actual method
      result = user.top_three_competitive_rounds_by_score

      # Make assertions
      expect(result).to eq(["round1", "round2", "round3"])
    end
  end


  describe "#last_three_competitive_games_rank" do
    it "returns the last three competitive games rank" do
      user = User.new

      # Stub the relevant methods and return values
      rounds_relation = double("ActiveRecord::Relation")
      allow(user).to receive(:rounds).and_return(rounds_relation)
      allow(rounds_relation).to receive(:where).and_return(rounds_relation)
      allow(rounds_relation).to receive(:order).with({ date: :desc }).and_return(rounds_relation)
      allow(rounds_relation).to receive(:limit).and_return(["round1", "round2", "round3"])

      # Call the actual method
      result = user.last_three_competitive_games_rank

      # Make assertions
      expect(result).to eq(["round1", "round2", "round3"])
    end
  end


  describe "#top_three_finishes_competitive" do
    it "returns the top three finishes in competitive games" do
      user = User.new
      competitive_rounds = double("competitive_rounds", where: double("where", order: double("order", limit: ["round1", "round2", "round3"])))
      allow(user).to receive(:rounds).and_return(competitive_rounds)

      expect(user.top_three_finishes_competitive).to eq(["round1", "round2", "round3"])
    end
  end


end