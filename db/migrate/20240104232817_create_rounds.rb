class CreateRounds < ActiveRecord::Migration[7.1]
  def change
    create_table :rounds do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :status
      t.integer :type
      t.string :target_weather_stats

      t.timestamps
    end
  end
end
