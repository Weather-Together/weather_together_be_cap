class AddGameTypeToUserGame < ActiveRecord::Migration[7.1]
  def change
    add_column :user_games, :game_type, :integer 
  
  end
end
