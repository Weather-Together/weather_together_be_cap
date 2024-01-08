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

  get 'api/v0/rounds/:id/votes', to: 'api/v0/rounds/votes#index'
  post 'api/v0/users/:user_id/rounds/:round_id/votes/new', to: 'api/v0/rounds/votes#create'
  
  get 'api/v0/users/:id/verify_account/:token', to: 'api/v0/users#verify_account', as: :verify_account
  post 'api/v0/users/:id/login', to: 'api/v0/users#login', as: :login
  get 'api/v0/verification_sent', to: 'api/v0/users#verification_sent', as: :verification_sent


  # API routes
  namespace :api do
    namespace :v0 do
      resources :users, only: [:new, :create] do
        resources :rounds, only: [:show], controller: 'users/rounds'
        get 'recent_rounds', to: 'users#recent_rounds'
      end
    end
  end
end

