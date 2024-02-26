class TestJob
  include Sidekiq::Job

  def perform(user_id)
    t1 = Time.now
    sleep(2)
    t2 = Time.now
    sleep(2)
    t3 = Time.now
    sleep(2)
    t4 = Time.now
    sleep(2)
    stuff =
    { 
      t1: t1,
      t2: t2,
      t3: t3,
      t4: t4,
      user: user_id
    }
    Rails.cache.write("user#{user_id}_stats", stuff, expires_in: 2.hours)
  end
end
