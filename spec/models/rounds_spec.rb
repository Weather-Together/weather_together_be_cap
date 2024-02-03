require "rails_helper"

RSpec.describe Round, type: :model do

  let(:game) { create(:game) }  # Assuming you have a factory or setup for creating a valid game


  describe "relationships" do
    it { should have_many(:votes) }
    it { should belong_to(:game) }
    it { should have_many(:users).through(:votes) }
  end


  # describe "validations" do
  #   it { should validate_presence_of(:status) }
  #   it { should validate_presence_of(:target_weather_stats) }
  # end

  describe "methods" do

    it "can turnover", :vcr do
      date = Date.yesterday.strftime('%F')
      @lat1 = "-15.74" ; @lon1 = "-54.34"
      @lat2 = "36.53" ; @lon2 = "-116.93"
      @lat3 = "39.74" ; @lon3 = "-104.99"
      wf = WeatherFacade.new
      lat11 = "62.04" ; lon11 = "129.74" ; data11 = wf.weather_data(lat11, lon11, date)
      lat12 = "78.22" ; lon12 = "15.63" ; data12 = wf.weather_data(lat12, lon12, date)
      lat13 = "27.99" ; lon13 = "86.93" ; data13 = wf.weather_data(lat13, lon13, date)
      lat14 = "14.24" ; lon14 = "40.92" ; data14 = wf.weather_data(lat14, lon14, date)
      lat15 = "22.10" ; lon15 = "-159.53" ; data15 = wf.weather_data(lat15, lon15, date)
      lat16 = "-6.32" ; lon16 = "143.96" ; data16 = wf.weather_data(lat16, lon16, date)
      
      public_games

      @user1 = User.create!(username: "username1", email: "user1@gmail.com", password: "password1")
      @user2 = User.create!(username: "username2", email: "user2@gmail.com", password: "password2")
      @user3 = User.create!(username: "username3", email: "user3@gmail.com", password: "password3")
      
      def populate_round(round)
        Vote.create!(user_id: @user1.id, round_id: round.id, lat: @lat1, lon: @lon1)
        Vote.create!(user_id: @user2.id, round_id: round.id, lat: @lat2, lon: @lon2)
        Vote.create!(user_id: @user3.id, round_id: round.id, lat: @lat3, lon: @lon3)
      end

      User.all.each do |user|
        UserGame.create!(user_id: user.id, game_id: @game1.id)
      end
      
      stub_ref = Date.today
      #Day 1
      allow(Round).to receive(:generate_target_data).and_return(data11)
      allow(Date).to receive(:today).and_return(stub_ref-5)
      Round.turnover
      populate_round(Round.all.last)

      expect(Round.all.count).to eq(1)
      expect(Round.all.last.open?).to be true

      #Day 2
      allow(Round).to receive(:generate_target_data).and_return(data12)
      allow(Date).to receive(:today).and_return(stub_ref-4)
      Round.turnover
      populate_round(Round.all.last)

      expect(Round.all.count).to eq(2)
      expect(Round.all.last.open?).to be true
      expect(Round.all.first.closed?).to be true
      expect(Round.all.first.open?).to be false
      expect(Round.all.first.processed?).to be false
      expect(Round.all.first.votes.first.processed?).to be false
      expect(Round.all.first.votes.first.unprocessed?).to be true

      #Day 3
      allow(Round).to receive(:generate_target_data).and_return(data13)
      allow(Date).to receive(:today).and_return(stub_ref-3)
      Round.turnover
      Round.turnover
      populate_round(Round.all.last)

      expect(Round.all.count).to eq(3)
      expect(Round.all.first.closed?).to be true
      expect(Round.all.first.open?).to be false
      expect(Round.all.first.processed?).to be false
      expect(Round.where(status: :closed).count).to eq 2

      #Day 4
      allow(Round).to receive(:generate_target_data).and_return(data14)
      allow(Date).to receive(:today).and_return(stub_ref-2)
      Round.turnover
      populate_round(Round.all.last)

      expect(Round.all.count).to eq(4)
      expect(Round.all.first.closed?).to be true
      expect(Round.all.first.open?).to be false
      expect(Round.all.first.processed?).to be false
      expect(Round.all.first.votes.first.score).to be nil
      expect(Round.where(status: :closed).count).to eq 3

      #Day 5
      allow(Round).to receive(:generate_target_data).and_return(data15)
      allow(Date).to receive(:today).and_return(stub_ref-1)
      Round.turnover
      populate_round(Round.all.last)

      expect(Round.all.count).to eq(5)
      expect(Round.all.first.closed?).to be false
      expect(Round.all.first.open?).to be false
      expect(Round.all.first.processed?).to be true
      expect(Round.all.first.votes.first.processed?).to be true
      expect(Round.all.first.votes.first.unprocessed?).to be false
      expect(Round.all.first.votes.first.score).to be_a Float
      expect(Round.where(status: :closed).count).to eq 3
      expect(Round.where(status: :processed).count).to eq 1

      #Day 6
      allow(Round).to receive(:generate_target_data).and_return(data16)
      allow(Date).to receive(:today).and_return(stub_ref)
      Round.turnover

      expect(Round.all.count).to eq(6)
      expect(Round.all.first.closed?).to be false
      expect(Round.all.first.open?).to be false
      expect(Round.all.first.processed?).to be true
      expect(Round.all.first.votes.first.processed?).to be true
      expect(Round.all.first.votes.first.unprocessed?).to be false
      expect(Round.all.first.votes.first.score).to be_a Float
      expect(Round.where(status: :closed).count).to eq 3
      expect(Round.where(status: :processed).count).to eq 2
    end

    it "can close_round", :vcr do
      test_data
      expect(@round.status).to eq("open")
      @round.close_round
      expect(@round.reload.status).to eq("closed")
    end

    it "can process_round", :vcr do
      test_data
      @round.close_round
      expect(@round.reload.status).to eq("closed")
      @round.process_round
      expect(@round.reload.status).to eq("processed")
    end
  end


  describe "generate_target_data" do
    #this test makes several API calls and cannot use VCR. Only enable if specifically troubleshooting this test
    xit "can generate a set of weather data for a random point on land" do
      VCR.turn_off!
      WebMock.allow_net_connect!
      Round.generate_target_data
      VCR.turn_on!
      WebMock.disable_net_connect!
    end
  end
end