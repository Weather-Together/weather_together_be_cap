class InviteMailerJob
  include Sidekiq::Job

  def perform(email, admin)
    InviteMailer.with(invitee: email, admin: admin).invite_email.deliver_now
  end
end