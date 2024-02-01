class RenameNameToLocationName < ActiveRecord::Migration[7.1]
  def change
    rename_column :votes, :name, :location_name
  end
end
