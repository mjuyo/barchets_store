Rails.application.routes.draw do
  devise_for :customers
  root to: 'home#index'
  get 'products', to: 'products#index'
  get 'categories/:id', to: 'products#category', as: 'category'
  resources :products, only: [:show]
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'contact_info', to: 'pages#contact_info', as: 'contact_info'
  get 'about_info', to: 'pages#about_info', as: 'about_info'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
