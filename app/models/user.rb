class User < ApplicationRecord
  has_many :votes
  has_many :user_games
  has_many :games, through: :user_games
  has_many :rounds, through: :games


end