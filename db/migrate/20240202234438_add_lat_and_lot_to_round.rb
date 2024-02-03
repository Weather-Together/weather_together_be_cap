class AddLatAndLotToRound < ActiveRecord::Migration[7.1]
  def change
    add_column :rounds, :lat, :string
    add_column :rounds, :lon, :string
  end
end
