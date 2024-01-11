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
      lat1 = "-15.74"
      lon1 = "-54.34"
      lat2 = "36.53"
      lon2 = "-116.93"
      lat3 = "39.74"
      lon3 = "-104.99"
      lat11 = "62.04"
      lon11 = "129.74"
      lat12 = "78.22"
      lon12 = "15.63"
      lat13 = "27.99"
      lon13 = "86.93"
      lat14 = "14.24"
      lon14 = "40.92"
      lat15 = "22.10"
      lon15 = "-159.53"
      lat16 = "-6.32"
      lon16 = "143.96"
      wf = WeatherFacade.new
      data11 = wf.weather_data(lat11, lon11, date)
      data12 = wf.weather_data(lat12, lon12, date)
      data13 = wf.weather_data(lat13, lon13, date)
      data14 = wf.weather_data(lat14, lon14, date)
      data15 = wf.weather_data(lat15, lon15, date)
      data16 = wf.weather_data(lat16, lon16, date)
      
      user1 = User.create!(username: "username1", email: "user1@gmail.com", password: "password1")
      user2 = User.create!(username: "username2", email: "user2@gmail.com", password: "password2")
      user3 = User.create!(username: "username3", email: "user3@gmail.com", password: "password3")
      
      game1 = Game.create!(length_in_days: 1000000, guess_lead_time: 3, player_cap: 10000, game_type: 0, results: nil)
      
      User.all.each do |user|
        UserGame.create!(user_id: user.id, game_id: @game1.id)
      end
      
      Round.all.each do |round|
        Vote.create!(user_id: user1.id, round_id: round.id, lat: lat1, lon: lon1)
        Vote.create!(user_id: user2.id, round_id: round.id, lat: lat2, lon: lon2)
        Vote.create!(user_id: user3.id, round_id: round.id, lat: lat3, lon: lon3)
      end
      allow(Round).to receive(generate_target_data).and_return(data11)
      stub_ref = Date.today
      allow(Date).to receive(:today).and_return(stub_ref-5)
      require 'pry'; binding.pry
      allow(Date).to receive(:today).and_return(stub_ref-4)
      require 'pry'; binding.pry
      allow(Date).to receive(:today).and_return(stub_ref-3)
      require 'pry'; binding.pry
      allow(Date).to receive(:today).and_return(stub_ref-2)
      require 'pry'; binding.pry
      allow(Date).to receive(:today).and_return(stub_ref-1)
      require 'pry'; binding.pry
      # expect(@round.status).to eq("open")
      # @round1.close_round
      # expect(@round.reload.status).to eq("closed")
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