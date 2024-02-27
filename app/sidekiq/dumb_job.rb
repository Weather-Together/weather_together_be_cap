class DumbJob
  include Sidekiq::Job

  def perform(params)
    t1 = Time.now
    t2 = Time.now
    sleep(2)
    t3 = Time.now
    t4 = Time.now
    stuff =
    { 
      t1: t1,
      t2: t2,
      t3: t3,
      t4: t4,
      user: params[:user_id]
    }
    Rails.cache.write("user#{params[:user_id]}_stats", stuff, expires_in: 2.hours)
  end
end
