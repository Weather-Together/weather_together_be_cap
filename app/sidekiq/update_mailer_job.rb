class UpdateMailerJob 
include Sidekiq::Job

  def perform(user_id, email, username)
    UpdateMailer.with(user_id: user_id, email: email, username: username).update_email.deliver_now
  end
end