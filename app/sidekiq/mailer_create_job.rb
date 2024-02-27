class MailerCreateJob
  include Sidekiq::Job

  def perform(user_id, email, verification_token)
    UserMailer.with(user_id: user_id, email: email, verification_token: verification_token).verification_email.deliver_now
  end
end