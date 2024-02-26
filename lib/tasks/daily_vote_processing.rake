namespace :daily_vote_processing do
  desc "Starts a new round, and calculates results of the previous round"
  task run: :environment do
    Round.turnover
  end
end

namespace :testing123 do
  desc "Starts a new round, and calculates results of the previous round"
  task hello_worldzz: :environment do
    p "Hello world!!!"
  end
end

namespace :populate_database do
  desc "Ensure that the database has any information"
  task seed: :environment do
    Vote.destroy_all
    UserGame.destroy_all
    Round.destroy_all
    Game.destroy_all
    User.destroy_all

    date = (Date.today-1).strftime('%F')
    lat1 = "-15.74"
    lon1 = "-54.34"
    lat2 = "36.53"
    lon2 = "-116.93"
    lat3 = "39.74"
    lon3 = "-104.99"
    lat4 = "39.95"
    lon4 = "-105.82"
    lat5 = "47.51"
    lon5 = "-111.28"
    lat6 = "-24.06"
    lon6 = "23.3"
    lat7 = "15.12"
    lon7 = "105.82"
    lat8 = "-10.72"
    lon8 = "142.46"
    lat9 = "-23.86"
    lon9 = "-69.14"
    lat10 = "46.8"
    lon10 = "10.3"
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
    #blaine's
    lat17 = "42.53"
    lon17 = "-70.98"
    lat18 = "44.33"
    lon18 = "-69.78"
    lat19 = "32.77"
    lon19 = "-91.91"
    lat20 = "38.20"
    lon20 = "-84.27"
    lat21 = "38.60"
    lon21 = "-95.27"
    lat22 = "42.46"
    lon22 = "-93.82"
    lat23 = "40.75"
    lon23 = "-86.07"
    lat24 = "37.71"
    lon24 = "-88.18"
    lat25 = "47.53"
    lon25 = "-116.12"
    lat26 = "32.03"
    lon26 = "-84.39"
    lat27 = "29.90"
    lon27 = "-81.32"
    lat28 = "33.40"
    lon28 = "-104.53"
    lat29 = "41.56"
    lon29 = "-72.68"
    lat30 = "39.37"
    lon30 = "-74.43"
    lat31 = "40.49"
    lon31 = "-106.84"


    wf = WeatherFacade.new
    data11 = wf.weather_data(lat11, lon11, date)
    data12 = wf.weather_data(lat12, lon12, date)
    data13 = wf.weather_data(lat13, lon13, date)
    data14 = wf.weather_data(lat14, lon14, date)
    data15 = wf.weather_data(lat15, lon15, date)
    data16 = wf.weather_data(lat16, lon16, date)
    data17 = wf.weather_data(lat17, lon17, date)
    data18 = wf.weather_data(lat18, lon18, date)
    data19 = wf.weather_data(lat19, lon19, date)  
    data20 = wf.weather_data(lat20, lon20, date)
    data21 = wf.weather_data(lat21, lon21, date)
    data22 = wf.weather_data(lat22, lon22, date)
    data23 = wf.weather_data(lat23, lon23, date)
    data24 = wf.weather_data(lat24, lon24, date)
    data25 = wf.weather_data(lat25, lon25, date)
    data26 = wf.weather_data(lat26, lon26, date)
    data27 = wf.weather_data(lat27, lon27, date)
    data28 = wf.weather_data(lat28, lon28, date)
    data29 = wf.weather_data(lat29, lon29, date)
    data30 = wf.weather_data(lat30, lon30, date)
    data31 = wf.weather_data(lat31, lon31, date)

    @game1 = Game.create!(length_in_days: 1000000, guess_lead_time: 3, player_cap: 10000, game_type: 0, results: nil)
    @daily_game = Game.create!(length_in_days: 1000000, guess_lead_time: 0, player_cap: 10000, game_type: 2, results: nil)

    @data1 = @data.to_json
    @user1 = User.create!(username: "username1", email: "user1@gmail.com", password: "password1", verified: 1)
    @user2 = User.create!(username: "username2", email: "user2@gmail.com", password: "password2", verified: 1)
    @user3 = User.create!(username: "username3", email: "user3@gmail.com", password: "password3", verified: 1)
    @user4 = User.create!(username: "username4", email: "user4@gmail.com", password: "password4", verified: 1)
    @user5 = User.create!(username: "username5", email: "user5@gmail.com", password: "password5", verified: 1)
    @user6 = User.create!(username: "username6", email: "user6@gmail.com", password: "password6")
    @user7 = User.create!(username: "username7", email: "user7@gmail.com", password: "password7")
    @user8 = User.create!(username: "username8", email: "user8@gmail.com", password: "password8")
    @user9 = User.create!(username: "username9", email: "user9@gmail.com", password: "password9")
    @user10 = User.create!(username: "username10", email: "user10@gmail.com", password: "password10")

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
    @round2 = Round.create!(game_id: @game1.id,
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
    @round2.update(close_date: (Date.today - 3).to_s, process_date: Date.today.to_s)
    @round3 = Round.create!(game_id: @game1.id,
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
    @round3.update(close_date: (Date.today - 2).to_s, process_date: (Date.today + 1).to_s)
    @round4 = Round.create!(game_id: @game1.id,
      location_name: data14[:location][:name],
      region: data14[:location][:region],
      country: data14[:location][:country],
      lat: data14[:location][:lat],
      lon: data14[:location][:lon],
      maxtemp_f: data14[:weather_data][:maxtemp_f],
      mintemp_f: data14[:weather_data][:mintemp_f],
      maxwind_mph: data14[:weather_data][:maxwind_mph],
      totalprecip_in: data14[:weather_data][:totalprecip_in],
      avgvis_miles: data14[:weather_data][:avgvis_miles],
      avghumidity: data14[:weather_data][:avghumidity],
      daily_chance_of_rain: data14[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data14[:weather_data][:daily_chance_of_snow])
    @round4.update(close_date: (Date.today - 1).to_s, process_date: (Date.today + 2).to_s)
    @round5 = Round.create!(game_id: @game1.id,
      location_name: data15[:location][:name],
      region: data15[:location][:region],
      country: data15[:location][:country],
      lat: data15[:location][:lat],
      lon: data15[:location][:lon],
      maxtemp_f: data15[:weather_data][:maxtemp_f],
      mintemp_f: data15[:weather_data][:mintemp_f],
      maxwind_mph: data15[:weather_data][:maxwind_mph],
      totalprecip_in: data15[:weather_data][:totalprecip_in],
      avgvis_miles: data15[:weather_data][:avgvis_miles],
      avghumidity: data15[:weather_data][:avghumidity],
      daily_chance_of_rain: data15[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data15[:weather_data][:daily_chance_of_snow])
    @round5.update(close_date: Date.today.to_s, process_date: (Date.today + 3).to_s)
    @round6 = Round.create!(game_id: @game1.id,
      location_name: data16[:location][:name],
      region: data16[:location][:region],
      country: data16[:location][:country],
      lat: data16[:location][:lat],
      lon: data16[:location][:lon],
      maxtemp_f: data16[:weather_data][:maxtemp_f],
      mintemp_f: data16[:weather_data][:mintemp_f],
      maxwind_mph: data16[:weather_data][:maxwind_mph],
      totalprecip_in: data16[:weather_data][:totalprecip_in],
      avgvis_miles: data16[:weather_data][:avgvis_miles],
      avghumidity: data16[:weather_data][:avghumidity],
      daily_chance_of_rain: data16[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data16[:weather_data][:daily_chance_of_snow])
    @round6.update(close_date: (Date.today+1).to_s, process_date: (Date.today + 4).to_s)
    @round13 = Round.create!(game_id: @game1.id,
      location_name: data17[:location][:name],
      region: data17[:location][:region],
      country: data17[:location][:country],
      lat: data17[:location][:lat],
      lon: data17[:location][:lon],
      maxtemp_f: data17[:weather_data][:maxtemp_f],
      mintemp_f: data17[:weather_data][:mintemp_f],
      maxwind_mph: data17[:weather_data][:maxwind_mph],
      totalprecip_in: data17[:weather_data][:totalprecip_in],
      avgvis_miles: data17[:weather_data][:avgvis_miles],
      avghumidity: data17[:weather_data][:avghumidity],
      daily_chance_of_rain: data17[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data17[:weather_data][:daily_chance_of_snow])
    @round13.update(close_date: (Date.today - 5).to_s, process_date: (Date.today - 2).to_s)
    @round14 = Round.create!(game_id: @game1.id,
      location_name: data18[:location][:name],
      region: data18[:location][:region],
      country: data18[:location][:country],
      lat: data18[:location][:lat],
      lon: data18[:location][:lon],
      maxtemp_f: data18[:weather_data][:maxtemp_f],
      mintemp_f: data18[:weather_data][:mintemp_f],
      maxwind_mph: data18[:weather_data][:maxwind_mph],
      totalprecip_in: data18[:weather_data][:totalprecip_in],
      avgvis_miles: data18[:weather_data][:avgvis_miles],
      avghumidity: data18[:weather_data][:avghumidity],
      daily_chance_of_rain: data18[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data18[:weather_data][:daily_chance_of_snow])
    @round14.update(close_date: (Date.today - 6).to_s, process_date: (Date.today - 3).to_s)
    @round15 = Round.create!(game_id: @game1.id,
      location_name: data20[:location][:name],
      region: data20[:location][:region],
      country: data20[:location][:country],
      lat: data20[:location][:lat],
      lon: data20[:location][:lon],
      maxtemp_f: data20[:weather_data][:maxtemp_f],
      mintemp_f: data20[:weather_data][:mintemp_f],
      maxwind_mph: data20[:weather_data][:maxwind_mph],
      totalprecip_in: data20[:weather_data][:totalprecip_in],
      avgvis_miles: data20[:weather_data][:avgvis_miles],
      avghumidity: data20[:weather_data][:avghumidity],
      daily_chance_of_rain: data20[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data20[:weather_data][:daily_chance_of_snow])
    @round15.update(close_date: (Date.today - 7).to_s, process_date: (Date.today - 4).to_s)
    @round16 = Round.create!(game_id: @game1.id,
      location_name: data19[:location][:name],
      region: data19[:location][:region],
      country: data19[:location][:country],
      lat: data19[:location][:lat],
      lon: data19[:location][:lon],
      maxtemp_f: data19[:weather_data][:maxtemp_f],
      mintemp_f: data19[:weather_data][:mintemp_f],
      maxwind_mph: data19[:weather_data][:maxwind_mph],
      totalprecip_in: data19[:weather_data][:totalprecip_in],
      avgvis_miles: data19[:weather_data][:avgvis_miles],
      avghumidity: data19[:weather_data][:avghumidity],
      daily_chance_of_rain: data19[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data19[:weather_data][:daily_chance_of_snow])
    @round16.update(close_date: (Date.today - 8).to_s, process_date: (Date.today - 5).to_s)
    @round17 = Round.create!(game_id: @game1.id,
      location_name: data21[:location][:name],
      region: data21[:location][:region],
      country: data21[:location][:country],
      lat: data21[:location][:lat],
      lon: data21[:location][:lon],
      maxtemp_f: data21[:weather_data][:maxtemp_f],
      mintemp_f: data21[:weather_data][:mintemp_f],
      maxwind_mph: data21[:weather_data][:maxwind_mph],
      totalprecip_in: data21[:weather_data][:totalprecip_in],
      avgvis_miles: data21[:weather_data][:avgvis_miles],
      avghumidity: data21[:weather_data][:avghumidity],
      daily_chance_of_rain: data21[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data21[:weather_data][:daily_chance_of_snow])
    @round17.update(close_date: (Date.today - 9).to_s, process_date: (Date.today - 6).to_s)
    @round18 = Round.create!(game_id: @game1.id,
      location_name: data22[:location][:name],
      region: data22[:location][:region],
      country: data22[:location][:country],
      lat: data22[:location][:lat],
      lon: data22[:location][:lon],
      maxtemp_f: data22[:weather_data][:maxtemp_f],
      mintemp_f: data22[:weather_data][:mintemp_f],
      maxwind_mph: data22[:weather_data][:maxwind_mph],
      totalprecip_in: data22[:weather_data][:totalprecip_in],
      avgvis_miles: data22[:weather_data][:avgvis_miles],
      avghumidity: data22[:weather_data][:avghumidity],
      daily_chance_of_rain: data22[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data22[:weather_data][:daily_chance_of_snow])
    @round18.update(close_date: (Date.today - 10).to_s, process_date: (Date.today - 7).to_s)
    @round19 = Round.create!(game_id: @game1.id,
      location_name: data23[:location][:name],
      region: data23[:location][:region],
      country: data23[:location][:country],
      lat: data23[:location][:lat],
      lon: data23[:location][:lon],
      maxtemp_f: data23[:weather_data][:maxtemp_f],
      mintemp_f: data23[:weather_data][:mintemp_f],
      maxwind_mph: data23[:weather_data][:maxwind_mph],
      totalprecip_in: data23[:weather_data][:totalprecip_in],
      avgvis_miles: data23[:weather_data][:avgvis_miles],
      avghumidity: data23[:weather_data][:avghumidity],
      daily_chance_of_rain: data23[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data23[:weather_data][:daily_chance_of_snow])
    @round19.update(close_date: (Date.today - 11).to_s, process_date: (Date.today - 8).to_s)
    @round26 = Round.create!(game_id: @game1.id,
      location_name: data30[:location][:name],
      region: data30[:location][:region],
      country: data30[:location][:country],
      lat: data30[:location][:lat],
      lon: data30[:location][:lon],
      maxtemp_f: data30[:weather_data][:maxtemp_f],
      mintemp_f: data30[:weather_data][:mintemp_f],
      maxwind_mph: data30[:weather_data][:maxwind_mph],
      totalprecip_in: data30[:weather_data][:totalprecip_in],
      avgvis_miles: data30[:weather_data][:avgvis_miles],
      avghumidity: data30[:weather_data][:avghumidity],
      daily_chance_of_rain: data30[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data30[:weather_data][:daily_chance_of_snow])
    @round26.update(close_date: (Date.today - 12).to_s, process_date: (Date.today - 9).to_s)
    @round27 = Round.create!(game_id: @game1.id,
      location_name: data31[:location][:name],
      region: data31[:location][:region],
      country: data31[:location][:country],
      lat: data31[:location][:lat],
      lon: data31[:location][:lon],
      maxtemp_f: data31[:weather_data][:maxtemp_f],
      mintemp_f: data31[:weather_data][:mintemp_f],
      maxwind_mph: data31[:weather_data][:maxwind_mph],
      totalprecip_in: data31[:weather_data][:totalprecip_in],
      avgvis_miles: data31[:weather_data][:avgvis_miles],
      avghumidity: data31[:weather_data][:avghumidity],
      daily_chance_of_rain: data31[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data31[:weather_data][:daily_chance_of_snow])
    @round27.update(close_date: (Date.today - 13).to_s, process_date: (Date.today - 10).to_s)
    @round7 = Round.create!(game_id: @daily_game.id,
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
    @round7.update(close_date: (Date.today - 4).to_s, process_date: (Date.today - 1).to_s)
    @round8 = Round.create!(game_id: @daily_game.id,
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
    @round8.update(close_date: (Date.today - 3).to_s, process_date: Date.today.to_s)
    @round9 = Round.create!(game_id: @daily_game.id,
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
    @round9.update(close_date: (Date.today - 2).to_s, process_date: (Date.today + 1).to_s)
    @round10 = Round.create!(game_id: @daily_game.id,
      location_name: data14[:location][:name],
      region: data14[:location][:region],
      country: data14[:location][:country],
      lat: data14[:location][:lat],
      lon: data14[:location][:lon],
      maxtemp_f: data14[:weather_data][:maxtemp_f],
      mintemp_f: data14[:weather_data][:mintemp_f],
      maxwind_mph: data14[:weather_data][:maxwind_mph],
      totalprecip_in: data14[:weather_data][:totalprecip_in],
      avgvis_miles: data14[:weather_data][:avgvis_miles],
      avghumidity: data14[:weather_data][:avghumidity],
      daily_chance_of_rain: data14[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data14[:weather_data][:daily_chance_of_snow])
    @round10.update(close_date: (Date.today - 1).to_s, process_date: (Date.today + 2).to_s)
    @round11 = Round.create!(game_id: @daily_game.id,
      location_name: data15[:location][:name],
      region: data15[:location][:region],
      country: data15[:location][:country],
      lat: data15[:location][:lat],
      lon: data15[:location][:lon],
      maxtemp_f: data15[:weather_data][:maxtemp_f],
      mintemp_f: data15[:weather_data][:mintemp_f],
      maxwind_mph: data15[:weather_data][:maxwind_mph],
      totalprecip_in: data15[:weather_data][:totalprecip_in],
      avgvis_miles: data15[:weather_data][:avgvis_miles],
      avghumidity: data15[:weather_data][:avghumidity],
      daily_chance_of_rain: data15[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data15[:weather_data][:daily_chance_of_snow])
    @round11.update(close_date: Date.today.to_s, process_date: (Date.today + 3).to_s)
    @round12 = Round.create!(game_id: @daily_game.id,
      location_name: data16[:location][:name],
      region: data16[:location][:region],
      country: data16[:location][:country],
      lat: data16[:location][:lat],
      lon: data16[:location][:lon],
      maxtemp_f: data16[:weather_data][:maxtemp_f],
      mintemp_f: data16[:weather_data][:mintemp_f],
      maxwind_mph: data16[:weather_data][:maxwind_mph],
      totalprecip_in: data16[:weather_data][:totalprecip_in],
      avgvis_miles: data16[:weather_data][:avgvis_miles],
      avghumidity: data16[:weather_data][:avghumidity],
      daily_chance_of_rain: data16[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data16[:weather_data][:daily_chance_of_snow])
    @round12.update(close_date: (Date.today+1).to_s, process_date: (Date.today + 4).to_s)
    @round20 = Round.create!(game_id: @daily_game.id,
      location_name: data24[:location][:name],
      region: data24[:location][:region],
      country: data24[:location][:country],
      lat: data24[:location][:lat],
      lon: data24[:location][:lon],
      maxtemp_f: data24[:weather_data][:maxtemp_f],
      mintemp_f: data24[:weather_data][:mintemp_f],
      maxwind_mph: data24[:weather_data][:maxwind_mph],
      totalprecip_in: data24[:weather_data][:totalprecip_in],
      avgvis_miles: data24[:weather_data][:avgvis_miles],
      avghumidity: data24[:weather_data][:avghumidity],
      daily_chance_of_rain: data24[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data24[:weather_data][:daily_chance_of_snow])
    @round20.update(close_date: (Date.today - 5).to_s, process_date: (Date.today - 2).to_s)
    @round21 = Round.create!(game_id: @daily_game.id,
      location_name: data25[:location][:name],
      region: data25[:location][:region],
      country: data25[:location][:country],
      lat: data25[:location][:lat],
      lon: data25[:location][:lon],
      maxtemp_f: data25[:weather_data][:maxtemp_f],
      mintemp_f: data25[:weather_data][:mintemp_f],
      maxwind_mph: data25[:weather_data][:maxwind_mph],
      totalprecip_in: data25[:weather_data][:totalprecip_in],
      avgvis_miles: data25[:weather_data][:avgvis_miles],
      avghumidity: data25[:weather_data][:avghumidity],
      daily_chance_of_rain: data25[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data25[:weather_data][:daily_chance_of_snow])
    @round21.update(close_date: (Date.today - 6).to_s, process_date: (Date.today - 3).to_s)
    @round22 = Round.create!(game_id: @daily_game.id,
      location_name: data26[:location][:name],
      region: data26[:location][:region],
      country: data26[:location][:country],
      lat: data26[:location][:lat],
      lon: data26[:location][:lon],
      maxtemp_f: data26[:weather_data][:maxtemp_f],
      mintemp_f: data26[:weather_data][:mintemp_f],
      maxwind_mph: data26[:weather_data][:maxwind_mph],
      totalprecip_in: data26[:weather_data][:totalprecip_in],
      avgvis_miles: data26[:weather_data][:avgvis_miles],
      avghumidity: data26[:weather_data][:avghumidity],
      daily_chance_of_rain: data26[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data26[:weather_data][:daily_chance_of_snow])
    @round22.update(close_date: (Date.today - 7).to_s, process_date: (Date.today - 4).to_s)
    @round23 = Round.create!(game_id: @daily_game.id,
      location_name: data27[:location][:name],
      region: data27[:location][:region],
      country: data27[:location][:country],
      lat: data27[:location][:lat],
      lon: data27[:location][:lon],
      maxtemp_f: data27[:weather_data][:maxtemp_f],
      mintemp_f: data27[:weather_data][:mintemp_f],
      maxwind_mph: data27[:weather_data][:maxwind_mph],
      totalprecip_in: data27[:weather_data][:totalprecip_in],
      avgvis_miles: data27[:weather_data][:avgvis_miles],
      avghumidity: data27[:weather_data][:avghumidity],
      daily_chance_of_rain: data27[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data27[:weather_data][:daily_chance_of_snow])
    @round23.update(close_date: (Date.today - 8).to_s, process_date: (Date.today - 5).to_s)
    @round24 = Round.create!(game_id: @daily_game.id,
      location_name: data28[:location][:name],
      region: data28[:location][:region],
      country: data28[:location][:country],
      lat: data28[:location][:lat],
      lon: data28[:location][:lon],
      maxtemp_f: data28[:weather_data][:maxtemp_f],
      mintemp_f: data28[:weather_data][:mintemp_f],
      maxwind_mph: data28[:weather_data][:maxwind_mph],
      totalprecip_in: data28[:weather_data][:totalprecip_in],
      avgvis_miles: data28[:weather_data][:avgvis_miles],
      avghumidity: data28[:weather_data][:avghumidity],
      daily_chance_of_rain: data28[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data28[:weather_data][:daily_chance_of_snow])
    @round24.update(close_date: (Date.today - 9).to_s, process_date: (Date.today - 6).to_s)
    @round25 = Round.create!(game_id: @daily_game.id,
      location_name: data29[:location][:name],
      region: data29[:location][:region],
      country: data29[:location][:country],
      lat: data29[:location][:lat],
      lon: data29[:location][:lon],
      maxtemp_f: data29[:weather_data][:maxtemp_f],
      mintemp_f: data29[:weather_data][:mintemp_f],
      maxwind_mph: data29[:weather_data][:maxwind_mph],
      totalprecip_in: data29[:weather_data][:totalprecip_in],
      avgvis_miles: data29[:weather_data][:avgvis_miles],
      avghumidity: data29[:weather_data][:avghumidity],
      daily_chance_of_rain: data29[:weather_data][:daily_chance_of_rain],
      daily_chance_of_snow: data29[:weather_data][:daily_chance_of_snow])
    @round25.update(close_date: (Date.today - 10).to_s, process_date: (Date.today - 7).to_s)



    Round.all.each do |round|
      Vote.create!(user_id: @user1.id, round_id: round.id, lat: lat1, lon: lon1)
      Vote.create!(user_id: @user2.id, round_id: round.id, lat: lat2, lon: lon2)
      Vote.create!(user_id: @user3.id, round_id: round.id, lat: lat3, lon: lon3)
      Vote.create!(user_id: @user4.id, round_id: round.id, lat: lat4, lon: lon4)
      Vote.create!(user_id: @user5.id, round_id: round.id, lat: lat5, lon: lon5)
      Vote.create!(user_id: @user6.id, round_id: round.id, lat: lat6, lon: lon6)
      Vote.create!(user_id: @user7.id, round_id: round.id, lat: lat7, lon: lon7)
      Vote.create!(user_id: @user8.id, round_id: round.id, lat: lat8, lon: lon8)
      Vote.create!(user_id: @user9.id, round_id: round.id, lat: lat9, lon: lon9)
      Vote.create!(user_id: @user10.id, round_id: round.id, lat: lat10, lon: lon10)
    end

    @round.close_round
    @round2.close_round
    @round3.close_round
    @round4.close_round
    @round5.close_round
    @round7.close_round
    @round8.close_round
    @round9.close_round
    @round10.close_round
    @round11.close_round
    @round13.close_round
    @round14.close_round
    @round15.close_round
    @round16.close_round
    @round17.close_round
    @round18.close_round
    @round19.close_round
    @round26.close_round
    @round20.close_round
    @round21.close_round
    @round22.close_round
    @round23.close_round
    @round24.close_round
    @round25.close_round


    
    @round.process_round
    @round2.process_round
    @round13.process_round
    @round14.process_round
    @round15.process_round
    @round16.process_round
    @round17.process_round
    @round18.process_round
    @round19.process_round
    @round26.process_round
    @round27.process_round


    @private_game1 = Game.create!(length_in_days: 151, guess_lead_time: 3, player_cap: 315, game_type: 1, name: "Prv Gam", results: nil)

    @user_game1 = UserGame.create!(user_id: @user1.id, game_id: @private_game1.id, invitation: :accepted)
    @user_game2 = UserGame.create!(user_id: @user2.id, game_id: @private_game1.id, invitation: :accepted)

    @private_round1 = Round.create!(game_id: @private_game1.id,
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
  end
end
