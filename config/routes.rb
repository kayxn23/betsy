Rails.application.routes.draw do

  get "/auth/:provider/callback", to: "sessions#create", as: "auth_callback"

  resources :orders, only: [:show, :new, :create]

  resources :sessions, only: [ :login, :destroy, :new ]
  # get 'sessions/login'
  # get 'sessions/destroy'
  # get 'sessions/new'
  resources :users, only: [ :new, :create, :show]
  # get 'users/new'
  # get 'users/create'
  # get 'users/show'
  resources :products
  # get '/products', to: 'products#index', as: 'products'
  # get '/products/:id', to: 'products#show', as: 'product'

  # get 'products/show'
  # get 'products/update'
  # get 'products/new'
  # get 'products/create'
  # get 'products/edit'
  # get 'products/destroy'
  resources :categories, only: [ :new, :create ]
  # get 'categories/new'
  # get 'categories/create'
  get '/cart', to: 'orders_items#index'
  resources :orders_items, path: '/cart/items'
  #resources :orders, only: [ :new, :create, :show ]
  # get 'orders/new'
  # get 'orders/create'
  # get 'orders/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
