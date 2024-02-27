class AnotherJob
  include Sidekiq::Job

  def perform
    t1 = Time.now
    sleep(1)
    t2 = Time.now
    sleep(1)
    t3 = Time.now
    sleep(1)
    t4 = Time.now
    sleep(1)
    rt = RedisTimestamp.create!(
      time1: t1,
      time2: t2,
      time3: t3,
      time4: t4
    )
  end
end
