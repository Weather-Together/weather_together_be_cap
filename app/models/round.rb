class Round < ApplicationRecord
  before_save do
    unless close_date
      self.close_date = find_close_date
    end
    unless process_date
      self.process_date = find_process_date
    end
    self.game_type = game.game_type
  end

  belongs_to :game
  has_many :votes
  has_many :users, through: :votes

  enum status: {open: 0, closed: 1, processed: 2}
  enum game_type: {competitive: 0, custom: 1, daily: 2}

  def self.turnover
    ongoing_games = Game.where(status: 0)
    ongoing_games.each do |game|
      target_data = generate_target_data
      round = Round.find_by(close_date: (Date.today + 1).to_s, game_id: game.id)
      unless round
        Round.create(game_id: game.id,
                    location_name: target_data[:location][:name],
                    region: target_data[:location][:region],
                    country: target_data[:location][:country],
                    lat: target_data[:location][:lat],
                    lon: target_data[:location][:lon],
                    maxtemp_f: target_data[:weather_data][:maxtemp_f],
                    mintemp_f: target_data[:weather_data][:mintemp_f],
                    maxwind_mph: target_data[:weather_data][:maxwind_mph],
                    totalprecip_in: target_data[:weather_data][:totalprecip_in],
                    avgvis_miles: target_data[:weather_data][:avgvis_miles],
                    avghumidity: target_data[:weather_data][:avghumidity],
                    daily_chance_of_rain: target_data[:weather_data][:daily_chance_of_rain],
                    daily_chance_of_snow: target_data[:weather_data][:daily_chance_of_snow])
      end
      closing_round = game.rounds.find_by(close_date: Date.today.to_s)
      closing_round.close_round if closing_round
      unless game.daily?
        processing_round = game.rounds.find_by(process_date: Date.today.to_s)
        processing_round.process_round if processing_round
      end
    end
    turnover = Turnover.find_by(successful_turnover_date: Date.today.to_s)
    unless turnover
      Turnover.create
    end
  end

  def close_round
    update(status: 1)
  end

  def process_round
    votes.each { |vote| 
      vote.process
      user = vote.user
      CompetitiveGameScoreMailerJob.perform_async(self.id, user.id, user.email)
     }
    update(status: 2)
  end

  def find_close_date
    (Date.today + 1).to_s
  end

  def find_process_date
    (Date.today + game.guess_lead_time + 1).to_s
  end

  def self.generate_target_data
    wf = WeatherFacade.new
    data = {error: {code: 1006, message: "No matching location found."}}
    while data[:error]
      lat = rand(-90.000...90.000)
      lon = rand(-180.000...180.000)
      data = wf.weather_data(lat, lon, (Date.today-1).strftime('%F'))
    end
    data
  end
  private
end