require 'sidekiq/web'
# require 'sidekiq/cron/web'

Rails.application.routes.draw do
  get "up" => "rails/health#show", :as => :rails_health_check

  # get "api/v0/turnover", :to 'api/v0/cron#turnover_confirm'
  get "api/v0/rounds/recent_rounds", to: 'api/v0/rounds#recent_rounds'
  get 'api/v0/rounds/current_competitive_round', to: 'api/v0/rounds#current_competitive_round'
  get "api/v0/turnover", to: 'api/v0/cron#turnover'
  get "api/v0/turnover_confirm", to: 'api/v0/cron#turnover_confirm'

  #daily rounds and voting
  get 'api/v0/users/:user_id/rounds/current_daily_round', to: 'api/v0/users/rounds#current_daily_round'
  post 'api/v0/users/:user_id/rounds/current_daily_round/vote', to: 'api/v0/users/rounds#daily_vote'

  #user stats
  get 'api/v0/users/:user_id/daily_stats', to: 'api/v0/users#daily_stats'
  get 'api/v0/users/:user_id/competitive_stats', to: 'api/v0/users#competitive_stats'

  #comp rounds and voting
  get 'api/v0/rounds/:id/votes', to: 'api/v0/rounds/votes#index'
  get 'api/v0/rounds/most_recent/results', to: 'api/v0/rounds/votes#results'
  get 'api/v0/rounds/:id/results', to: 'api/v0/rounds/votes#results'
  get 'api/v0/users/:user_id/rounds/current_competitive_round', to: 'api/v0/users/rounds#current_competitive_round'
  post 'api/v0/users/:user_id/rounds/:round_id/votes/new', to: 'api/v0/rounds/votes#create'
  
  #login
  get 'api/v0/users/:id/verify_account/:token', to: 'api/v0/users#verify_account', as: :verify_account
  post 'api/v0/users/login', to: 'api/v0/users#login', as: :login
  get 'api/v0/verification_sent', to: 'api/v0/users#verification_sent', as: :verification_sent
  post 'api/v0/users/oauth_login', to: 'api/v0/users#find_or_create'

  #private/custom games
  get 'api/v0/users/:id/games', to: 'api/v0/users/games#index'
  post 'api/v0/users/:id/games', to: 'api/v0/users/games#create'
  get 'api/v0/users/:id/games/:game_id', to: 'api/v0/users/games#show'
  patch 'api/v0/users/:id/games/:game_id', to: 'api/v0/users/games#invite_rsvp'
  get 'api/v0/users/:id/games/:game_id/current_round', to: 'api/v0/users/games#current_round'
  post 'api/v0/users/:user_id/games/:game_id/vote', to: 'api/v0/users/games#vote'
  post 'api/v0/users/:user_id/games/:game_id/invite', to: 'api/v0/users/games#invite'

  #redis test
  get 'api/v0/redis_test/long_task', to: 'api/v0/redis_test#long_task'
  get 'api/v0/redis_test/long_task_confirm', to: 'api/v0/redis_test#long_task_confirm'
  get 'api/v0/redis_test/cache_test', to: 'api/v0/redis_test#cache_test'
  get 'api/v0/redis_test/cache_confirm', to: 'api/v0/redis_test#cache_confirm'


  # API routes
  namespace :api do
    namespace :v0 do
      resources :rounds, only: [:show, :index]

      resources :users, only: [:new, :create, :index, :show] do
        resources :rounds, only: [:show], controller: "users/rounds"
        get "recent_rounds", to: "users#recent_rounds"
      end
    end
  end

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(Rails.application.credentials.redis[:username])) &
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(Rails.application.credentials.redis[:password]))
  end
  mount Sidekiq::Web => '/'
end
