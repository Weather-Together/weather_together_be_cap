class User < ApplicationRecord
  has_secure_password

  has_many :votes
  has_many :user_games
  has_many :games, through: :user_games
  has_many :rounds, through: :games

  validates_presence_of :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :verified
end