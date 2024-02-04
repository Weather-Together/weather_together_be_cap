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

   before(:all) do
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
      expect(user.average_score_in_daily_games).to be_a(Float).or be_nil
    end
  end

  describe "#date_and_score_of_best_daily_score" do
    it "returns the correct date and score of the best daily score" do
      user = User.find_by(username: 'user1')
      result = user.date_and_score_of_best_daily_score

      expect(result[:date]).to be_a(Date).or be_nil
      expect(result[:score]).to be_a(Float).or be_nil
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
      expect(result.length).to eq(5)
      expect(result[0]).to have_key(:username)
      expect(result[0]).to have_key(:average_score)
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

      expect(result).to be_an(ActiveRecord::Relation)
      expect(result.count).to eq(3)
    end
  end



end



















#   describe "#daily_game_count" do
#     it "returns the count of daily games" do
#       user = User.new
#       allow(user).to receive(:games).and_return(double("games", where: double("games", count: 5)))
      
#       expect(user.daily_game_count).to eq(5)
#     end
#   end

#   describe "#average_score_in_daily_games" do
#     it "returns the average score in daily games" do
#       user = User.new
#       rounds_double = double("rounds", where: double("rounds", average: 80))

#       allow(user).to receive(:rounds).and_return(rounds_double)

#       expect(user.average_score_in_daily_games).to eq(80)
#     end
#   end


#   describe "#date_and_score_of_best_daily_score" do
#     it "returns the date and score of the highest daily score" do
#       user = User.new
#       highest_score_round = double("round", created_at: Time.now, score: 100)
      
#       allow(user).to receive_message_chain(:rounds, :where, :order, :first).and_return(highest_score_round)

#       expect(user.date_and_score_of_best_daily_score).to eq({ date: Time.now.to_date, score: 100 })
#     end

#     it "returns nil if there is no highest score round" do
#       user = User.new

#       allow(user).to receive_message_chain(:rounds, :where, :order, :first).and_return(nil)

#       expect(user.date_and_score_of_best_daily_score).to eq({ date: nil, score: nil })
#     end
#   end

#   describe "#grade_book_daily_round" do
#     it "returns the count of daily rounds in different score ranges" do
#       user = User.new
#       allow(user).to receive(:rounds).and_return(double("rounds", where: double("rounds", where: double("rounds", count: 3))))
      
#       expect(user.grade_book_daily_round).to eq({
#         '0.00-500.00' => 3,
#         '500.01-1000.00' => 3,
#         '1000.01-2000.00' => 3,
#         '2000.01-5000.00' => 3,
#         '5000.01+' => 3
#       })
#     end
#   end

# describe "#user_competitive_rank" do
#   it "returns the competitive rank of the user" do
#     user = User.new
#     rounds_double = double("rounds")
#     allow(rounds_double).to receive_message_chain(:joins, :where, :group, :select, :to_sql).and_return("subquery")
#     allow(rounds_double).to receive(:average).and_return(50)
#     allow(user).to receive(:rounds).and_return(rounds_double)
    
#     user_double = double("User")
#     allow(User).to receive(:joins).and_return(user_double)
#     allow(user_double).to receive_message_chain(:where, :count).and_return(5)
    
#     expect(user.user_competitive_rank).to eq(6)
#   end
# end



# it "returns the top 5 competitive users" do
#   user = User.new
#   user_double = double("User")
#   allow(User).to receive(:joins).and_return(user_double)
#   allow(user_double).to receive_message_chain(:where, :group, :order, :limit, :pluck).and_return([["user1", 100], ["user2", 90], ["user3", 80], ["user4", 70], ["user5", 60]])

#   expect(User.top_5_competitive_users).to eq([["user1", 100], ["user2", 90], ["user3", 80], ["user4", 70], ["user5", 60]])
# end

#   describe "#competitive_game_count" do
#     it "returns the count of competitive games" do
#       user = User.new
#       allow(user).to receive(:games).and_return(double("games", where: double("games", count: 5)))
      
#       expect(user.competitive_game_count).to eq(5)
#     end
#   end

#  describe "#average_score_in_competitive_games" do
#   it "returns the average score in competitive games" do
#     user = User.new

#     # Stub the relevant methods and return values
#     allow(user).to receive_message_chain(:rounds, :where, :average).and_return(80)

#     # Call the actual method
#     result = user.average_score_in_competitive_games

#     # Make assertions
#     expect(result).to eq(80)
#   end
# end


#   describe "#top_three_competitive_rounds_by_score" do
#     it "returns the top three competitive rounds by score" do
#       user = User.new

#       # Stub the relevant methods and return values
#       rounds_relation = double("ActiveRecord::Relation")
#       allow(user).to receive(:rounds).and_return(rounds_relation)
#       allow(rounds_relation).to receive(:where).and_return(rounds_relation)
#       allow(rounds_relation).to receive(:order).and_return(rounds_relation)
#       allow(rounds_relation).to receive(:limit).and_return(["round1", "round2", "round3"])

#       # Call the actual method
#       result = user.top_three_competitive_rounds_by_score

#       # Make assertions
#       expect(result).to eq(["round1", "round2", "round3"])
#     end
#   end


#   describe "#last_three_competitive_games_rank" do
#   it "returns the last three competitive games rank" do
#     user = User.new

#     # Stub the relevant methods and return values
#     rounds_relation = double("ActiveRecord::Relation")
#     game_relation = double("ActiveRecord::Relation")
#     round_double = double("Round", id: 1) # Stub the id method here
#     votes_relation = double("ActiveRecord::Relation")

#     allow(user).to receive(:rounds).and_return(rounds_relation)
#     allow(rounds_relation).to receive(:joins).with(:game).and_return(game_relation)
#     allow(game_relation).to receive(:where).and_return(game_relation)
#     allow(game_relation).to receive(:order).with(date: :desc).and_return(game_relation)
#     allow(game_relation).to receive(:limit).and_return([round_double, round_double, round_double])
#     allow(round_double).to receive(:votes).and_return(votes_relation)
#     allow(votes_relation).to receive(:joins).with(:user).and_return(votes_relation)
#     allow(votes_relation).to receive(:where).and_return(votes_relation)
#     allow(votes_relation).to receive(:order).with('votes.score ASC').and_return(votes_relation)
#     allow(votes_relation).to receive(:pluck).with(:user_id).and_return([1, 2, 3])
#     allow(user).to receive(:id).and_return(1)

#     # Call the actual method
#     result = user.last_three_competitive_games_rank

#     # Make assertions
#     expect(result).to eq([{ round_id: 1, user_rank: 1 }, { round_id: 1, user_rank: 1 }, { round_id: 1, user_rank: 1 }])
#   end
# end


#   describe "#top_three_finishes_competitive" do
#     it "returns the top three finishes in competitive games" do
#       user = User.new
#       competitive_rounds = double("competitive_rounds", where: double("where", order: double("order", limit: ["round1", "round2", "round3"])))
#       allow(user).to receive(:rounds).and_return(competitive_rounds)

#       expect(user.top_three_finishes_competitive).to eq(["round1", "round2", "round3"])
#     end
#   end