Rails.application.routes.draw do

  get "/auth/:provider/callback", to: "sessions#create"

  resources :orders, only: [:show, :new, :create]
  # get 'sessions/login'
  # get 'sessions/destroy'
  # get 'sessions/new'
  # get 'users/new'
  # get 'users/create'
  # get 'users/show'
  # get 'products/index'
  # get 'products/show'
  # get 'products/update'
  # get 'products/new'
  # get 'products/create'
  # get 'products/edit'
  # get 'products/destroy'
  # get 'categories/new'
  # get 'categories/create'
  # get 'orders/new'
  # get 'orders/create'
  # get 'orders/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
