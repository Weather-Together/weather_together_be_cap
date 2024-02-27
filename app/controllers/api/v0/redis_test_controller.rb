class Api::V0::RedisTestController < ApplicationController
  def long_task
    HardJob.perform_async
    render json: { data: "Your timestamps are being created"}
  end

  def long_task_confirm
    last = RedisTimestamp.all.count
    rt = RedisTimestamp.find(last)
    render json: RedisTimestampSerializer.new(rt)
  end

  def cache_test
    DumbJob.perform_async(params[:user_id])
    # t1 = Time.now
    # t2 = Time.now
    # sleep(2)
    # t3 = Time.now
    # t4 = Time.now
    # stuff =
    # { 
    #   t1: t1,
    #   t2: t2,
    #   t3: t3,
    #   t4: t4,
    #   user: params[:user_id]
    # }
    # Rails.cache.write("user#{params[:user_id]}_stats", stuff, expires_in: 2.hours)

    render json: { data: "User #{params[:user_id]}, your timestamps are being created"}
  end

  def cache_confirm
    daily_stats = Rails.cache.read("user#{params[:user_id]}_stats") || { "message": "No data for user"}
    render json: { data: daily_stats}
  end
end

