class User < ApplicationRecord
  has_many :votes
  has_many :user_games


end