Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v0 do
      resources :users, only: [:new, :create]

    end
  end

  get 'api/v0/rounds/:id/votes', to: 'api/v0/rounds/votes#index'
  post 'api/v0/users/:user_id/rounds/:round_id/votes/new', to: 'api/v0/rounds/votes#create'
  
  get 'api/v0/users/:id/verify_account/:token', to: 'api/v0/users#verify_account', as: :verify_account
  post 'api/v0/users/:id/login', to: 'api/v0/users#login', as: :login
  get 'api/v0/verification_sent', to: 'api/v0/users#verification_sent', as: :verification_sent

  # Defines the root path route ("/")
  # root "posts#index"
end
