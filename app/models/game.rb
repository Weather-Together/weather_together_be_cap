class Game < ApplicationRecord
  before_save do
    unless start_date
      self.start_date = find_start_date
    end
    unless close_date
      self.close_date = find_close_date
    end
  end

  has_many :rounds
  has_many :user_games
  has_many :users, through: :user_games

  enum status: {open: 0, closed: 1}
  enum game_type: {competitive: 0, custom: 1, daily: 2}

  def self.current_competitive_round
    Game.find_by(game_type: 0).rounds.order(close_date: :desc).first
  end

  def self.current_daily_round
    Game.find_by(game_type: 2).rounds.order(close_date: :desc).first
  end

  def self.competitive_game
    Game.find_by(game_type: 0)
  end

  def self.daily_game
    Game.find_by(game_type: 2)
  end

  def find_start_date
    (Date.today + 1).to_s
  end

  def find_close_date
    (Date.today + length_in_days + 1).to_s
  end

  def current_round
    rounds.order(close_date: :desc).first
  end
end
