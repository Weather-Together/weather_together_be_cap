class PutDefaultsVotes < ActiveRecord::Migration[7.1]
  def change
    change_column_default :votes, :status, 0
    change_column_default :votes, :type, 0
  end
end
