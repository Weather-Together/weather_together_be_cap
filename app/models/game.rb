class Game < ApplicationRecord
  before_save do
    unless self.start_date
      self.start_date = self.find_start_date
    end
    unless self.close_date
      self.close_date = self.find_close_date
    end
  end

  has_many :rounds
  has_many :user_games
  has_many :users, through: :user_games

  enum status: { open: 0, closed: 1 }
  enum game_type: { community: 0, custom: 1, daily: 2 }

  def self.current_community_round
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