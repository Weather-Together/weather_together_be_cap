class UserGame < ApplicationRecord
  belongs_to :user
  belongs_to :game
  has_many :rounds, through: :game


end