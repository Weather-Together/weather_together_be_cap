namespace :daily_vote_processing do
  desc "Starts a new round, and calculates results of the previous round"
  task :run do
    #Starts the new round
    #Closes and Calculates score for each round ending today
    Round.turnover

  end
end