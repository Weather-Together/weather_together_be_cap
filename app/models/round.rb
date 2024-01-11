class Round < ApplicationRecord
  before_save do
    unless self.close_date
      self.close_date = self.find_close_date
    end
    unless self.process_date
      self.process_date = self.find_process_date
    end
    self.game_type = self.game.game_type
  end

  belongs_to :game
  has_many :votes
  has_many :users, through: :votes

  enum status: { open: 0, closed: 1, processed: 2 }
  enum game_type: { community: 0, custom: 1 }

  def self.turnover
    target_data = generate_target_data
    ongoing_games = Game.where(status: 0)
    ongoing_games.each do |game|
      round = Round.find_by(close_date: (Date.today+1).to_s, game_id: game.id)
      unless round  
        Round.create(target_weather_stats: target_data, game_id: game.id)
      end
      closing_round = game.rounds.find_by(close_date: Date.today.to_s)
      closing_round.close_round if closing_round
      processing_round = game.rounds.find_by(process_date: Date.today.to_s)
      processing_round.process_round if processing_round
    end
  end

  def close_round
    update(status: 1)
  end

  def process_round
    votes.each { |vote| vote.process }
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
    data = {:error=>{:code=>1006, :message=>"No matching location found."}}.to_json
    while JSON.parse(data, symbolize_names: true)[:error]
      lat = rand(-90.000...90.000)
      lon = rand(-180.000...180.000)
      data = wf.weather_data(lat, lon, Date.yesterday.strftime('%F'))
    end
    data
  end
end