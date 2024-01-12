class Game < ApplicationRecord
  has_many :rounds
  has_many :user_games
  has_many :users, through: :user_games

  enum status: { open: 0, closed: 1 }
  enum game_type: { community: 0, custom: 1 }

  def self.current_community_round
    Game.find_by(game_type: 0).rounds.order(close_date: :desc).first
  end
end