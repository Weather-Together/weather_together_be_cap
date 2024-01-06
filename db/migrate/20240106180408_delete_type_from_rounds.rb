class DeleteTypeFromRounds < ActiveRecord::Migration[7.1]
  def change
    remove_column :rounds, :type
  end
end
