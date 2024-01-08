class AddProcessDateToRounds < ActiveRecord::Migration[7.1]
  def change
    add_column :rounds, :process_date, :string
  end
end
