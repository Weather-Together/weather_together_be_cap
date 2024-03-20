class CompetitiveGameScoreMailer < ApplicationMailer
  def competitive_game_score_email(round_id, user_id, email)
    @round = Round.find(round_id)
    @user = User.find(user_id)
    @score = @round.votes.find_by(user_id: user_id)&.score
    @round_start_date = @round.start_date

    mail(to: email, subject: "Competitive Game Score Update for #{@round_start_date}")
  end
end
