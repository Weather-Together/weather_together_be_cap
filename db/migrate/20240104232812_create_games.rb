class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.integer :type
      t.integer :length_in_days
      t.integer :guess_lead_time
      t.integer :player_cap
      t.integer :status
      t.string :results

      t.timestamps
    end
  end
end
