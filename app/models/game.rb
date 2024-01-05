class Game < ApplicationRecord
  has_many :rounds
  has_many :user_games
  has_many :users, through: :user_games

end