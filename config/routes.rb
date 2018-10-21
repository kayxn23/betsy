Rails.application.routes.draw do

  root "products#index"

  get "/auth/:provider/callback", to: "sessions#login", as: "auth_callback"
  delete "/logout", to: "sessions#destroy", as: "logout"


  resources :orders, only: [:show, :new, :create]

  # get 'sessions/login'
  # get 'sessions/destroy'
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
  resources :orders, only: [ :new, :create, :show ]
  # get 'orders/new'
  # get 'orders/create'
  # get 'orders/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
