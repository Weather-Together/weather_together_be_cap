class UserStatsJob
  include Sidekiq::Job

  def perform(user_id)
    @user = User.find(user_id)

    Rails.cache.fetch("#{user_id}/user_stats", expires_in: 12.hours) do
      sleep(4)
      {
        daily_game_count: @user.daily_game_count,
        average_score_in_daily_games: @user.average_score_in_daily_games,
        date_and_score_of_best_daily_score: @user.date_and_score_of_best_daily_score,
        grade_book_daily_round: @user.grade_book_daily_round
      }
    end
  end
end
