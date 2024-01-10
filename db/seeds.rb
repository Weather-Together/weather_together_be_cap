# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

date = Date.yesterday.strftime('%F')
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
wf = WeatherFacade.new
data11 = wf.weather_data(lat11, lon11, date)
data12 = wf.weather_data(lat12, lon12, date)
data13 = wf.weather_data(lat13, lon13, date)
data14 = wf.weather_data(lat14, lon14, date)
data15 = wf.weather_data(lat15, lon15, date)
data16 = wf.weather_data(lat16, lon16, date)

@data1 = @data.to_json
@user1 = User.create!(username: "username1", email: "user1@gmail.com", password: "password1")
@user2 = User.create!(username: "username2", email: "user2@gmail.com", password: "password2")
@user3 = User.create!(username: "username3", email: "user3@gmail.com", password: "password3")
@user4 = User.create!(username: "username4", email: "user4@gmail.com", password: "password4")
@user5 = User.create!(username: "username5", email: "user5@gmail.com", password: "password5")
@user6 = User.create!(username: "username6", email: "user6@gmail.com", password: "password6")
@user7 = User.create!(username: "username7", email: "user7@gmail.com", password: "password7")
@user8 = User.create!(username: "username8", email: "user8@gmail.com", password: "password8")
@user9 = User.create!(username: "username9", email: "user9@gmail.com", password: "password9")
@user10 = User.create!(username: "username10", email: "user10@gmail.com", password: "password10")

@game1 = Game.create!(length_in_days: 1000000, guess_lead_time: 3, player_cap: 10000, game_type: 0, results: nil)

User.all.each do |user|
  UserGame.create!(user_id: user.id, game_id: @game1.id)
end


@round = Round.create!(game_id: @game1.id, target_weather_stats: data11)
@round.update(close_date: (Date.today-4).to_s, process_date: (Date.today-1).to_s)
@round2 = Round.create!(game_id: @game1.id, target_weather_stats: data12)
@round2.update(close_date: (Date.today-3).to_s, process_date: (Date.today).to_s)
@round3 = Round.create!(game_id: @game1.id, target_weather_stats: data13)
@round3.update(close_date: (Date.today-2).to_s, process_date: (Date.today+1).to_s)
@round4 = Round.create!(game_id: @game1.id, target_weather_stats: data14)
@round4.update(close_date: (Date.today-1).to_s, process_date: (Date.today+2).to_s)
@round5 = Round.create!(game_id: @game1.id, target_weather_stats: data15)
@round5.update(close_date: (Date.today).to_s, process_date: (Date.today+3).to_s)
@round6 = Round.create!(game_id: @game1.id, target_weather_stats: data16)

Round.all.each do |round|
  Vote.create!(user_id: @user1.id, round_id: round.id, lat: lat1, lon: lon1, target_weather_stats: round.target_weather_stats)
  Vote.create!(user_id: @user2.id, round_id: round.id, lat: lat2, lon: lon2, target_weather_stats: round.target_weather_stats)
  Vote.create!(user_id: @user3.id, round_id: round.id, lat: lat3, lon: lon3, target_weather_stats: round.target_weather_stats)
  Vote.create!(user_id: @user4.id, round_id: round.id, lat: lat4, lon: lon4, target_weather_stats: round.target_weather_stats)
  Vote.create!(user_id: @user5.id, round_id: round.id, lat: lat5, lon: lon5, target_weather_stats: round.target_weather_stats)
  Vote.create!(user_id: @user6.id, round_id: round.id, lat: lat6, lon: lon6, target_weather_stats: round.target_weather_stats)
  Vote.create!(user_id: @user7.id, round_id: round.id, lat: lat7, lon: lon7, target_weather_stats: round.target_weather_stats)
  Vote.create!(user_id: @user8.id, round_id: round.id, lat: lat8, lon: lon8, target_weather_stats: round.target_weather_stats)
  Vote.create!(user_id: @user9.id, round_id: round.id, lat: lat9, lon: lon9, target_weather_stats: round.target_weather_stats)
  Vote.create!(user_id: @user10.id, round_id: round.id, lat: lat10, lon: lon10, target_weather_stats: round.target_weather_stats)
end
