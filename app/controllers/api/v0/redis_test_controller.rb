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
end

