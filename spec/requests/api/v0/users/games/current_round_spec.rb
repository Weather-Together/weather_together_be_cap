require 'rails_helper'

RSpec.describe "Current Private Game Round", :vcr do
  
  it "Can fetch the current round for a private game" do
    public_games

    @user1 = User.create!(username: "username1", email: "user1@gmail.com", password: "password1")

    new_game = {
      "name": "Storm Chasers",
      "length_in_days": 145,
      "guess_lead_time": 12,
      "player_cap": 12,
      "invitees": ["user2@gmail.com", "user3@gmail.com"]
      }
      post "/api/v0/users/#{@user1.id}/games" , params: new_game.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
      game_id = game = JSON.parse(response.body, symbolize_names: true)[:data][:id]
    
      date = Date.yesterday.strftime('%F')
      lat11 = "62.04"
      lon11 = "129.74"
      lat12 = "78.22"
      lon12 = "15.63"
      lat13 = "27.99"
      lon13 = "86.93"
      wf = WeatherFacade.new
      data11 = wf.weather_data(lat11, lon11, date)
      data12 = wf.weather_data(lat12, lon12, date)
      data13 = wf.weather_data(lat13, lon13, date)
      @round = Round.create!(game_id: game_id,
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
        daily_chance_of_snow: data11[:weather_data][:daily_chance_of_snow]
      )
      @round.update(close_date: (Date.today-1).to_s, process_date: (Date.today+11).to_s)
      @round2 = Round.create!(game_id: game_id, 
        location_name: data12[:location][:name],
        region: data12[:location][:region],
        country: data12[:location][:country],
        lat: data12[:location][:lat],
        lon: data12[:location][:lon],
        maxtemp_f: data12[:weather_data][:maxtemp_f],
        mintemp_f: data12[:weather_data][:mintemp_f],
        maxwind_mph: data12[:weather_data][:maxwind_mph],
        totalprecip_in: data12[:weather_data][:totalprecip_in],
        avgvis_miles: data12[:weather_data][:avgvis_miles],
        avghumidity: data12[:weather_data][:avghumidity],
        daily_chance_of_rain: data12[:weather_data][:daily_chance_of_rain],
        daily_chance_of_snow: data12[:weather_data][:daily_chance_of_snow])
      @round2.update(close_date: (Date.today).to_s, process_date: (Date.today+12).to_s)
      @round3 = Round.create!(game_id: game_id, 
        location_name: data13[:location][:name],
        region: data13[:location][:region],
        country: data13[:location][:country],
        lat: data13[:location][:lat],
        lon: data13[:location][:lon],
        maxtemp_f: data13[:weather_data][:maxtemp_f],
        mintemp_f: data13[:weather_data][:mintemp_f],
        maxwind_mph: data13[:weather_data][:maxwind_mph],
        totalprecip_in: data13[:weather_data][:totalprecip_in],
        avgvis_miles: data13[:weather_data][:avgvis_miles],
        avghumidity: data13[:weather_data][:avghumidity],
        daily_chance_of_rain: data13[:weather_data][:daily_chance_of_rain],
        daily_chance_of_snow: data13[:weather_data][:daily_chance_of_snow])


      get "/api/v0/users/#{@user1.id}/games/#{game_id}/current_round"
    
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
  
      game = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(game[:id].to_i).to be_an Integer
      expect(game[:id].to_i).to eq(@round3.id)
      expect(game[:type]).to eq("bulkround")
      expect(game[:attributes][:status]).to eq("open")
      expect(game[:attributes][:close_date]).to eq(@round3.close_date)
      expect(game[:attributes][:number_of_votes]).to eq(0)
  
      expect(game[:attributes][:location_name]).to eq(@round3.location_name)
      expect(game[:attributes][:maxtemp_f]).to eq(@round3.maxtemp_f)
      expect(game[:attributes][:avghumidity]).to eq(@round3.avghumidity)
  end
end