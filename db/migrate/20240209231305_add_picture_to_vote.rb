class AddPictureToVote < ActiveRecord::Migration[7.1]
  def change
    add_column :votes, :image, :string
    add_column :votes, :wiki, :string
  end
end
