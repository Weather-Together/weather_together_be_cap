web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -e production -C config/initializers/sidekiq.yml
release: bundle exec rake db:migrate