class Round < ApplicationRecord
  belongs_to :game
  has_many :votes
  has_many :users, through: :votes

end