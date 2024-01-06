class AddCloseDateToRound < ActiveRecord::Migration[7.1]
  def change
    add_column :rounds, :close_date, :string
  end
end
