Rails.application.routes.draw do
  devise_for :users

  get 'cart/add/:id', to: 'cart#add', as: 'add_to_cart'
  get 'cart/show', to: 'cart#show', as: 'cart'
  delete 'cart/remove/:id', to: 'cart#remove', as: 'remove_from_cart'
  patch 'cart/update_quantity/:id', to: 'cart#update_quantity', as: 'update_cart_quantity'

  root 'products#index'
  get 'products/index'
  get 'products/show'
  get 'products/search', to: 'products#search', as: 'search_products'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :products, only: [:index, :show]
  resources :orders, only: [:new, :create, :show, :index]
  resources :carts, only: [:show, :update, :destroy]
  resources :reviews, only: [:create, :update, :destroy]
  get 'categories/:id', to: 'categories#show', as: 'category'
  get 'about', to: 'pages#about'
  get 'contact', to: 'pages#contact'
end
