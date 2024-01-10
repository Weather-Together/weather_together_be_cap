class ChangeVoteScoreToFloat < ActiveRecord::Migration[7.1]
  def change
    remove_column :votes, :score
    add_column :votes, :score, :float
  end
end
