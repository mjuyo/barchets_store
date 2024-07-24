Rails.application.routes.draw do
  devise_for :customers
  root to: 'home#index'

  resources :products, only: [:index, :show] do
    collection do
      get :on_sale
      get :new_products
      get :recently_updated
    end

    member do
      post 'add_to_cart'
      post 'remove_from_cart'
    end
  end
  
  resources :orders, only: [:new, :create]

  resource :cart, only: [:show]

  post 'add_to_cart/:product_id', to: 'carts#add_to_cart', as: 'add_to_cart'
  delete 'remove_from_cart/:product_id', to: 'carts#remove_from_cart', as: 'remove_from_cart'
  patch 'update_cart/:product_id', to: 'carts#update_cart', as: 'update_cart'

  resources :orders, only: [:new, :create]

  get 'categories/:id', to: 'products#category', as: 'category'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'contact_info', to: 'pages#contact_info', as: 'contact_info'
  get 'about_info', to: 'pages#about_info', as: 'about_info'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

end
