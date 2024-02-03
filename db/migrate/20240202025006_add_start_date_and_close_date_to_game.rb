class AddStartDateAndCloseDateToGame < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :start_date, :string
    add_column :games, :close_date, :string
  end
end
