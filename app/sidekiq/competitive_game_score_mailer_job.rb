class CompetitiveGameScoreMailerJob
  include Sidekiq::Job

  def perform(round_id, user_id, email)
    CompetitiveGameScoreMailer.competitive_game_score_email(round_id, user_id, email).deliver_now
  end
end
