class Turnover < ApplicationRecord
  before_save do
    self.successful_turnover_date = Date.today.to_s
  end
end
