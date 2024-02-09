class UserGame < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :rounds, through: :game

  enum invitation: {sent: 0, accepted: 1, declined: 2, admin: 3}
  enum game_type: {competitive: 0, custom: 1, daily: 2}

  before_create do 
    self.game_type = game.game_type
  end
end
