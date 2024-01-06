class PutDefaultsOnGames < ActiveRecord::Migration[7.1]
  def change
    change_column_default :games, :status, 0
  end
end
