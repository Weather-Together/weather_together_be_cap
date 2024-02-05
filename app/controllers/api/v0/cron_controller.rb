class Api::V0::CronController < ApplicationController
  def turnover
    Round.turnover
    turnover = Turnover.find_by(successful_turnover_date: Date.today.to_s)
    if turnover
      turnover.update(success: true)
      render json: TurnoverSerializer.new(turnover)
    else
      turnover = Turnover.create
      render json: TurnoverSerializer.new(turnover)
    end
  end

  def turnover_confirm
    render json: TurnoverSerializer.new(Turnover.all.last)
  end
end
