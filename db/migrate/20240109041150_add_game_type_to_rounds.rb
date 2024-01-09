class AddGameTypeToRounds < ActiveRecord::Migration[7.1]
  def change
    add_column :rounds, :game_type, :integer
  end
end
