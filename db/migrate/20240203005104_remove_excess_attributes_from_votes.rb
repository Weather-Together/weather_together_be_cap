class RemoveExcessAttributesFromVotes < ActiveRecord::Migration[7.1]
  def change
    remove_column :votes, :target_weather_stats
    remove_column :votes, :weather_stats
    remove_column :votes, :daily_will_it_rain
    remove_column :votes, :daily_will_it_snow
  end
end
