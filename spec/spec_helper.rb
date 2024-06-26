# This file was generated by the `rails generate rspec:install` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# The generated `.rspec` file contains `--require spec_helper` which will cause
# this file to always be loaded, without a need to explicitly require it in any
# files.
#
require 'webmock/rspec'
# Given that it is always loaded, you are encouraged to keep this file as
# light-weight as possible. Requiring heavyweight dependencies from this file
# will add to the boot time of your test suite on EVERY test run, even for an
# individual file that may not need all of that loaded. Instead, consider making
# a separate helper file that requires the additional dependencies and performs
# the additional setup, and require it from the spec files that actually need
# it.
#
# See https://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
def public_games
  @game1 = Game.create!(length_in_days: 1000000, guess_lead_time: 3, player_cap: 10000, game_type: 0, results: nil)
  @daily_game = Game.create!(length_in_days: 1000000, guess_lead_time: 0, player_cap: 10000, game_type: 2, results: nil)  
end

def test_data
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
  wf = WeatherFacade.new
  @data11 = wf.weather_data(lat11, lon11, date)
  data12 = wf.weather_data(lat12, lon12, date)
  data13 = wf.weather_data(lat13, lon13, date)
  data14 = wf.weather_data(lat14, lon14, date)
  data15 = wf.weather_data(lat15, lon15, date)
  data16 = wf.weather_data(lat16, lon16, date)

  @game1 = Game.create!(length_in_days: 1000000, guess_lead_time: 3, player_cap: 10000, game_type: 0, results: nil)
  @daily_game = Game.create!(length_in_days: 1000000, guess_lead_time: 0, player_cap: 10000, game_type: 2, results: nil)

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


  @round = Round.create!(game_id: @game1.id,
                        location_name: @data11[:location][:name],
                        region: @data11[:location][:region],
                        country: @data11[:location][:country],
                        lat: @data11[:location][:lat],
                        lon: @data11[:location][:lon],
                        maxtemp_f: @data11[:weather_data][:maxtemp_f],
                        mintemp_f: @data11[:weather_data][:mintemp_f],
                        maxwind_mph: @data11[:weather_data][:maxwind_mph],
                        totalprecip_in: @data11[:weather_data][:totalprecip_in],
                        avgvis_miles: @data11[:weather_data][:avgvis_miles],
                        avghumidity: @data11[:weather_data][:avghumidity],
                        daily_chance_of_rain: @data11[:weather_data][:daily_chance_of_rain],
                        daily_chance_of_snow: @data11[:weather_data][:daily_chance_of_snow]
                        )
  @round.update(close_date: (Date.today-4).to_s, process_date: (Date.today-1).to_s)
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
  @round2.update(close_date: (Date.today-3).to_s, process_date: (Date.today).to_s)
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
  @round3.update(close_date: (Date.today-2).to_s, process_date: (Date.today+1).to_s)
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
  @round4.update(close_date: (Date.today-1).to_s, process_date: (Date.today+2).to_s)
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
  @round5.update(close_date: (Date.today).to_s, process_date: (Date.today+3).to_s)
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


  @round7 = Round.create!(game_id: @daily_game.id,
                        location_name: @data11[:location][:name],
                        region: @data11[:location][:region],
                        country: @data11[:location][:country],
                        lat: @data11[:location][:lat],
                        lon: @data11[:location][:lon],
                        maxtemp_f: @data11[:weather_data][:maxtemp_f],
                        mintemp_f: @data11[:weather_data][:mintemp_f],
                        maxwind_mph: @data11[:weather_data][:maxwind_mph],
                        totalprecip_in: @data11[:weather_data][:totalprecip_in],
                        avgvis_miles: @data11[:weather_data][:avgvis_miles],
                        avghumidity: @data11[:weather_data][:avghumidity],
                        daily_chance_of_rain: @data11[:weather_data][:daily_chance_of_rain],
                        daily_chance_of_snow: @data11[:weather_data][:daily_chance_of_snow]
                      )
  @round7.update(close_date: (Date.today-4).to_s, process_date: (Date.today-1).to_s)
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
  @round8.update(close_date: (Date.today-3).to_s, process_date: (Date.today).to_s)
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
  @round9.update(close_date: (Date.today-2).to_s, process_date: (Date.today+1).to_s)
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
  @round10.update(close_date: (Date.today-1).to_s, process_date: (Date.today+2).to_s)
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
  @round11.update(close_date: (Date.today).to_s, process_date: (Date.today+3).to_s)
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
end

RSpec.configure do |config|
  # rspec-expectations config goes here. You can use an alternate
  # assertion/expectation library such as wrong or the stdlib/minitest
  # assertions if you prefer.
  config.expect_with :rspec do |expectations|
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  # This option will default to `:apply_to_host_groups` in RSpec 4 (and will
  # have no way to turn it off -- the option exists only for backwards
  # compatibility in RSpec 3). It causes shared context metadata to be
  # inherited by the metadata hash of host groups and examples, rather than
  # triggering implicit auto-inclusion in groups with matching metadata.
  config.shared_context_metadata_behavior = :apply_to_host_groups

# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.
=begin
  # This allows you to limit a spec run to individual examples or groups
  # you care about by tagging them with `:focus` metadata. When nothing
  # is tagged with `:focus`, all examples get run. RSpec also provides
  # aliases for `it`, `describe`, and `context` that include `:focus`
  # metadata: `fit`, `fdescribe` and `fcontext`, respectively.
  config.filter_run_when_matching :focus

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  # https://rspec.info/features/3-12/rspec-core/configuration/zero-monkey-patching-mode/
  config.disable_monkey_patching!

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = "doc"
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
=end
end
