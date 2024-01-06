class PutDefaultsRounds < ActiveRecord::Migration[7.1]
  def change
    change_column_default :rounds, :status, 0
    change_column_default :rounds, :type, 0
  end
end
