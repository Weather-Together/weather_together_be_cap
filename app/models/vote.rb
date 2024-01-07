class Vote < ApplicationRecord
  before_save do
    self.target_weather_stats = round.target_weather_stats
  end
  belongs_to :user
  belongs_to :round

  enum status: { unprocessed: 0, processed: 1 }
  
  def process(weather_data)
    score = 0 #calculate score
    update(status: :processed, score: score)
  end
end