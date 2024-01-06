# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

@data = {:location=>
  {:name=>"Fraser",
   :region=>"Colorado",
   :country=>"United States of America",
   :lat=>39.95,
   :lon=>-105.82,
   :tz_id=>"America/Denver",
   :localtime_epoch=>1704515214,
   :localtime=>"2024-01-05 21:26"},
 :weather_data=>
  {:maxtemp_c=>-7.4,
   :maxtemp_f=>18.7,
   :mintemp_c=>-14.1,
   :mintemp_f=>6.5,
   :avgtemp_c=>-10.9,
   :avgtemp_f=>12.3,
   :maxwind_mph=>7.2,
   :maxwind_kph=>11.5,
   :totalprecip_mm=>2.26,
   :totalprecip_in=>0.09,
   :totalsnow_cm=>1.72,
   :avgvis_km=>7.5,
   :avgvis_miles=>4.0,
   :avghumidity=>91,
   :daily_will_it_rain=>0,
   :daily_chance_of_rain=>0,
   :daily_will_it_snow=>1,
   :daily_chance_of_snow=>100,
   :condition=>{:text=>"Moderate or heavy snow showers", :icon=>"//cdn.weatherapi.com/weather/64x64/day/371.png", :code=>1258},
   :uv=>1.0}}
   @data = @data.to_json
@user1 = User.create!(username: "username1", email: "user1@gmail.com", password: "password1")
@user2 = User.create!(username: "username2", email: "user2@gmail.com", password: "password2")

@game1 = Game.create!(length_in_days: 1000000, guess_lead_time: 3, player_cap: 10000, game_type: 0, results: nil)

UserGame.create!(user_id: @user1.id, game_id: @game1.id)
UserGame.create!(user_id: @user2.id, game_id: @game1.id)

@round1 = Round.create!(game_id: @game1.id, target_weather_stats: @data)
@round2 = Round.create!(game_id: @game1.id, target_weather_stats: @data)

@vote1 = Vote.create!(user_id: @user1.id, round_id: @round1.id, lat: "0", lon: "0", target_weather_stats: @data)
@vote1 = Vote.create!(user_id: @user2.id, round_id: @round1.id, lat: "39.95", lon: "105.82", target_weather_stats: @data)
