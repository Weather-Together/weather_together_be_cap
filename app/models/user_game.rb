class UserGame < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :rounds, through: :game

  enum invitation: {sent: 0, accepted: 1, declined: 2, admin: 3}
end
