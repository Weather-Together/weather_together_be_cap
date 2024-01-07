Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Users routes
  resources :users, only: [:new, :create] do
    get 'verify_account/:token', to: 'users#verify_account', on: :member, as: :verify_account
  end
  get 'verification_sent', to: 'users#verification_sent', as: :verification_sent

  # API routes
  namespace :api do
    namespace :v0 do
      resources :users, only: [:new, :create] do
        resources :rounds, only: [:show], controller: 'users/rounds'
      end
    end
  end
end

