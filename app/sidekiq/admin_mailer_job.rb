class AdminMailerJob
  include Sidekiq::Job

  def perform(admin_user, game_name, missing_accounts)
    AdminNotifierMailer.with(admin: admin_user, game_name: game_name, missing_accounts: missing_accounts).notify_email.deliver_now
  end
end