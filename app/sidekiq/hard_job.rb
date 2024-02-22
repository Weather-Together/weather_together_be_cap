class HardJob
  include Sidekiq::Job

  def self.perform
    puts "I'm working hard!"
  end
end
