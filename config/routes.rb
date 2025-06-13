Rails.application.routes.draw do
  # Root path
  root "dashboard#index"

  # Devise routes (with custom registration controller)
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  # Dashboard (shared for all roles via DashboardController)
  get "dashboard", to: "dashboard#index"

  # Health check (default Rails)
  get "up", to: "rails/health#show", as: :rails_health_check

  # Admin namespace for admin-only functionality
  namespace :admin do
    resources :users, only: [:index, :new, :create]
    resources :stores, only: [:index, :new, :create]
  end

  # Store listing (used for normal users and admins)
  resources :stores, only: [:index] do
    resources :ratings, only: [:create] do
      delete :clear, on: :collection
    end
  end
end
