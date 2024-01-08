class Round < ApplicationRecord
  before_save do
    self.close_date = self.find_close_date
  end

  belongs_to :game
  has_many :votes
  has_many :users, through: :votes

  enum status: { open: 0, closed: 1, processed: 2 }

  def self.turnover
    target_data = generate_target_data
    ongoing_games = Game.where(status: 0)
    ongoing_games.each do |game|
      Round.create(target_weather_stats: target_data, game_id: game.id)
      closing_round = game.rounds.find_by(close_date: Date.today.to_s)
      closing_round.close_round
    end
  end

  def close_round
    votes.each { |vote| vote.process }
  end

  def find_close_date
    (Date.today + game.guess_lead_time + 1).to_s
  end

  def generate_target_data
    lat = rand(-90.000...90.000)
    lon = rand(-180.000...180.000)
    wf = WeatherFacade.new
    wf.weather_data(lat, lon)
  end
end