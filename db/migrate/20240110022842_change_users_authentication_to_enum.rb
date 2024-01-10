class ChangeUsersAuthenticationToEnum < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :verified
    add_column :users, :verified, :integer
    change_column_default :users, :verified, 0
  end
end
