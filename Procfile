web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq #-e production -C config/initializers/sidekiq.yml
release: bundle exec rake db:migrate && rake populate_database:seed && export OTEL_EXPORTER_OTLP_ENDPOINT="https://api.honeycomb.io" && export OTEL_EXPORTER_OTLP_HEADERS="x-honeycomb-team=ajoxd06xUSX2fB5Dc9AauD" && export OTEL_SERVICE_NAME="weather_together_be_cap"