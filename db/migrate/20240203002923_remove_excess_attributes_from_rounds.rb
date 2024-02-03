class RemoveExcessAttributesFromRounds < ActiveRecord::Migration[7.1]
  def change
    remove_column :rounds, :target_weather_stats
    remove_column :rounds, :daily_will_it_rain
    remove_column :rounds, :daily_will_it_snow
  end
end
