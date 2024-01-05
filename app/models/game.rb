class Game < ApplicationRecord
  has_many :rounds
  has_many :user_games

end