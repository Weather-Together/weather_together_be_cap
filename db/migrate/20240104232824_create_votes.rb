class CreateVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :round, null: false, foreign_key: true
      t.integer :status
      t.integer :type
      t.string :target_weather_stats
      t.string :lat
      t.string :lon
      t.string :weather_stats
      t.string :score

      t.timestamps
    end
  end
end
