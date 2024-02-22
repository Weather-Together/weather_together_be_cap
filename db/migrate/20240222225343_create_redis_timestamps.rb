class CreateRedisTimestamps < ActiveRecord::Migration[7.1]
  def change
    create_table :redis_timestamps do |t|
      t.string :time1
      t.string :time2
      t.string :time3
      t.string :time4

      t.timestamps
    end
  end
end
