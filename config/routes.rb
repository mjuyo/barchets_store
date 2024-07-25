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
      post 'add_to_cart', to: 'carts#add'
      delete 'remove_from_cart', to: 'carts#remove'
    end
  end
  
  resources :orders, only: [:new, :create, :show]

  resource :cart, only: [:show] do
    patch 'add/:id', to: 'carts#add', as: 'add'
    patch 'decrease/:id', to: 'carts#decrease', as: 'decrease'
    delete 'remove/:id', to: 'carts#remove', as: 'remove'
  end

  post 'add_to_cart/:product_id', to: 'carts#add', as: 'add_to_cart'

  resources :orders, only: [:new, :create]

  get 'categories/:id', to: 'products#category', as: 'category'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'contact_info', to: 'pages#contact_info', as: 'contact_info'
  get 'about_info', to: 'pages#about_info', as: 'about_info'

  get "up" => "rails/health#show", as: :rails_health_check
end
