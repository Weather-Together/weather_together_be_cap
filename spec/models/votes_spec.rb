require "rails_helper"

RSpec.describe Vote, type: :model do
  describe "relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:round) }
  end

  describe "calculate_score" do
    it "can calculate a score", :vcr do
      test_data
      vote = Vote.all.first
      expect(vote.score).to be nil
      weather_data = WeatherFacade.new.weather_data(vote.lat, vote.lon, (Date.today-1).strftime('%F'))
      score = vote.calculate_score(weather_data)
      expect(score > 0).to be true
    end
  end

  describe "process" do
    it "can update vote", :vcr do
      test_data
      vote = Vote.all.first
      vote_id = vote.id
      expect(vote.score).to be nil
      expect(vote.unprocessed?).to be true
      expect(vote.processed?).to be false
      vote.process

      vote = Vote.find(vote_id)
      expect(vote.unprocessed?).to be false
      expect(vote.processed?).to be true
      expect(vote.location_name).to be_a(String)
      expect(vote.score > 0).to be true
    end

    # this test makes several API calls and cannot use VCR. Only enable if specifically troubleshooting this test
    xit "will choose a random location if an ocean location is chosen" do
      VCR.turn_off!
      WebMock.allow_net_connect!

      date = (Date.today-1).strftime('%F')
      public_games
      lat1 = "-43.5596"
      lon1 = "-5.9504"
      lat11 = "62.04"
      lon11 = "129.74"

      wf = WeatherFacade.new
      data11 = wf.weather_data(lat11, lon11, date)

      @user1 = User.create!(username: "username1", email: "user1@gmail.com", password: "password1")
      @game1 = Game.create!(length_in_days: 1000000, guess_lead_time: 3, player_cap: 10000, game_type: 0, results: nil)

      User.all.each do |user|
        UserGame.create!(user_id: user.id, game_id: @game1.id)
      end

      @round = Round.create!(game_id: @game1.id,
        location_name: data11[:location][:name],
        region: data11[:location][:region],
        country: data11[:location][:country],
        lat: data11[:location][:lat],
        lon: data11[:location][:lon],
        maxtemp_f: data11[:weather_data][:maxtemp_f],
        mintemp_f: data11[:weather_data][:mintemp_f],
        maxwind_mph: data11[:weather_data][:maxwind_mph],
        totalprecip_in: data11[:weather_data][:totalprecip_in],
        avgvis_miles: data11[:weather_data][:avgvis_miles],
        avghumidity: data11[:weather_data][:avghumidity],
        daily_chance_of_rain: data11[:weather_data][:daily_chance_of_rain],
        daily_chance_of_snow: data11[:weather_data][:daily_chance_of_snow])
      @round.update(close_date: (Date.today - 4).to_s, process_date: (Date.today - 1).to_s)

      Round.all.each do |round|
        Vote.create!(user_id: @user1.id, round_id: round.id, lat: lat1, lon: lon1)
      end
      vote = Vote.all.first
      vote_id = vote.id
      # expect(vote.weather_stats).to be nil
      expect(vote.score).to be nil
      expect(vote.unprocessed?).to be true
      expect(vote.processed?).to be false
      vote.process

      vote = Vote.find(vote_id)
      expect(vote.unprocessed?).to be false
      expect(vote.processed?).to be true
      # expect(vote.weather_stats).to be_a(String)
      # weather_data = JSON.parse(vote.weather_stats, symbolize_names: true)
      # expect(weather_data).to be_a(Hash)
      # expect(weather_data[:location][:lat]).to_not eq(lat1)
      # expect(weather_data[:location][:lon]).to_not eq(lon1)
      expect(vote.score > 0).to be true

      VCR.turn_on!
      WebMock.disable_net_connect!
    end
  end
end
