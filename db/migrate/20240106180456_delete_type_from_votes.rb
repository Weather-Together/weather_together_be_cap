class DeleteTypeFromVotes < ActiveRecord::Migration[7.1]
  def change
    remove_column :votes, :type
  end
end
