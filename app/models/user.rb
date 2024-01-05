class User < ApplicationRecord
  has_many :votes
  has_many :user_games
  has_many :games, through: :user_games
  has_many :rounds, through: :games

  before_create :generate_verification_token

  def generate_verification_token
    self.verification_token = SecureRandom.urlsafe_base64
  end
end