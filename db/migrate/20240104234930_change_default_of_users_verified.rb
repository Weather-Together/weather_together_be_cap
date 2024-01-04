class ChangeDefaultOfUsersVerified < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :verified, false
  end
end
