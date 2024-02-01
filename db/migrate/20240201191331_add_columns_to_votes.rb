class AddColumnsToVotes < ActiveRecord::Migration[7.1]
  def change
    add_column :votes, :name, :string
    add_column :votes, :region, :string
    add_column :votes, :country, :string
    add_column :votes, :maxtemp_f, :float
    add_column :votes, :mintemp_f, :float
    add_column :votes, :avgtemp_f, :float
    add_column :votes, :maxwind_mph, :float
    add_column :votes, :totalprecip_in, :float
    add_column :votes, :avgvis_miles, :float
    add_column :votes, :avghumidity, :integer
    add_column :votes, :daily_will_it_rain, :integer
    add_column :votes, :daily_chance_of_rain, :integer
    add_column :votes, :daily_will_it_snow, :integer
    add_column :votes, :daily_chance_of_snow, :integer
  end
end
