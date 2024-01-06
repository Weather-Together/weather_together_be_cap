class User < ApplicationRecord
  has_secure_password

  has_many :votes
  has_many :user_games
  has_many :games, through: :user_games
  has_many :rounds, through: :games


  before_create :generate_verification_token
  
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }


  def generate_verification_token
    self.verification_token = SecureRandom.urlsafe_base64
  end

end