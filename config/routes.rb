Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, only: [:new, :create]

  get 'users/:id/verify_account/:token', to: 'users#verify_account', as: :verify_account
  get 'verification_sent', to: 'users#verification_sent', as: :verification_sent

  # Defines the root path route ("/")
  # root "posts#index"
end
