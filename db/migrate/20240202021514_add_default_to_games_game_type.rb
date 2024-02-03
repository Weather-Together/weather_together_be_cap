class AddDefaultToGamesGameType < ActiveRecord::Migration[7.1]
  def change
    change_column_default :games, :game_type, 1
  end
end
