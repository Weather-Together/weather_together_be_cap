class AddColumnsToRounds < ActiveRecord::Migration[7.1]
  def change
    add_column :rounds, :location_name, :string
    add_column :rounds, :region, :string
    add_column :rounds, :country, :string
    add_column :rounds, :maxtemp_f, :float
    add_column :rounds, :mintemp_f, :float
    add_column :rounds, :avgtemp_f, :float
    add_column :rounds, :maxwind_mph, :float
    add_column :rounds, :totalprecip_in, :float
    add_column :rounds, :avgvis_miles, :float
    add_column :rounds, :avghumidity, :integer
    add_column :rounds, :daily_will_it_rain, :integer
    add_column :rounds, :daily_chance_of_rain, :integer
    add_column :rounds, :daily_will_it_snow, :integer
    add_column :rounds, :daily_chance_of_snow, :integer
  end
end
