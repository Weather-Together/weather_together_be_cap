class AddInvitationtoUserGames < ActiveRecord::Migration[7.1]
  def change
    add_column :user_games, :invitation, :integer
    change_column_default :user_games, :invitation, 0
  end
end
