Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check


  # Users routes
#   resources :users, only: [:new, :create] do
#     get 'verify_account/:token', to: 'users#verify_account', on: :member, as: :verify_account
#   end
#   get 'verification_sent', to: 'users#verification_sent', as: :verification_sent

#   namespace :api do
#     namespace :v0 do
#       resources :users, only: [:new, :create]

#     end
#   end
  
  # get "api/v0/turnover", :to 'api/v0/cron#turnover_confirm'
  get "api/v0/rounds/recent_rounds", to: 'api/v0/rounds#recent_rounds'
  get 'api/v0/rounds/current_community_round', to: 'api/v0/rounds#current_community_round'
  get "api/v0/turnover", to: 'api/v0/cron#turnover'
  get "api/v0/turnover_confirm", to: 'api/v0/cron#turnover_confirm'

  #daily rounds and voting
  get 'api/v0/users/:user_id/rounds/current_daily_round', to: 'api/v0/users/rounds#current_daily_round'



  #comp rounds and voting
  get 'api/v0/rounds/:id/votes', to: 'api/v0/rounds/votes#index'
  get 'api/v0/rounds/most_recent/results', to: 'api/v0/rounds/votes#results'
  get 'api/v0/rounds/:id/results', to: 'api/v0/rounds/votes#results'
  get 'api/v0/users/:user_id/rounds/current_community_round', to: 'api/v0/users/rounds#current_community_round'
  post 'api/v0/users/:user_id/rounds/:round_id/votes/new', to: 'api/v0/rounds/votes#create'
  
  #login
  get 'api/v0/users/:id/verify_account/:token', to: 'api/v0/users#verify_account', as: :verify_account
  post 'api/v0/users/login', to: 'api/v0/users#login', as: :login
  get 'api/v0/verification_sent', to: 'api/v0/users#verification_sent', as: :verification_sent
  post 'api/v0/users/oauth_login', to: 'api/v0/users#find_or_create'

  #private/custom games
  post 'api/v0/users/:id/games', to: 'api/v0/users/games#create'
  get 'api/v0/users/:id/games/:game_id', to: 'api/v0/users/games#show'
  patch 'api/v0/users/:id/games/:game_id', to: 'api/v0/users/games#invite_rsvp'
  get 'api/v0/users/:id/games/:game_id/current_round', to: 'api/v0/users/games#current_round'



  # API routes
  namespace :api do
    namespace :v0 do

      resources :rounds, only: [:show, :index]

      resources :users, only: [:new, :create, :index] do
        resources :rounds, only: [:show], controller: 'users/rounds'
        get 'recent_rounds', to: 'users#recent_rounds'
      end

    end
  end
end

