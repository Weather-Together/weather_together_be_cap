class Game < ApplicationRecord
  has_many :rounds
  has_many :user_games
  has_many :users, through: :user_games

  enum status: { open: 0, closed: 1 }
  enum type: { public: 0, private: 1 }
end