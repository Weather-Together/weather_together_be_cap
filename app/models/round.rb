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
    Game.where(status: )
    Round.create(target_weather_stats: :target_data)
    closing_rounds = Round.where(closing)
  end

  def close_round

  end

  def find_close_date
    (Date.today + game.guess_lead_time).to_s
  end
end