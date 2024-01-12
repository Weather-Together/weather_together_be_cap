class User < ApplicationRecord
  has_secure_password

  has_many :votes
  has_many :user_games
  has_many :games, through: :user_games
  has_many :rounds, through: :games


  before_create :generate_verification_token
  
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }

  enum verified: { unverified: 0, verified: 1, oauth: 2 }

  def generate_verification_token
    self.verification_token = SecureRandom.urlsafe_base64
  end

  def previous_public_rounds
    @recent_rounds = rounds
                          .where(game_type: 0)
                          .order(created_at: :desc)
                          .limit(3)
                          .includes(:votes)
  end

  def self.username_generator
    "#{Faker::Adjective.positive.capitalize}#{Faker::Creature::Animal.name.capitalize}"
  end

end