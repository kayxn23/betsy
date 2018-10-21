Rails.application.routes.draw do
  root 'products#root'

  root "products#index"

  get "/auth/:provider/callback", to: "sessions#login", as: "auth_callback"
  delete "/logout", to: "sessions#destroy", as: "logout"
  get "users/:id/dashboard", to: "users#dashboard", as: "dashboard"
  get "users/:user_id/products", to: "user#products", as: "merchant_products"

  resources :orders, only: [:show, :new, :create]

  # get 'sessions/login'
  # get 'sessions/destroy'
  resources :users, only: [ :new, :create, :index]

# Creates route for user_products so we can link each merchant to
# users/:user_id/products
  # resources :users, only: [:show] do
  #   resources :products, only: [:index]
  # end
  # TODO Added nested routes for orderitems

  # get 'users/new'
  # get 'users/create'
  # get 'users/show'
  resources :products, except: [:destroy]
  post '/products/:id/retire', to: "products#retire", as: "retire"
  # get '/products', to: 'products#index', as: 'products'
  # get '/products/:id', to: 'products#show', as: 'product'

  # get 'products/show'
  # get 'products/update'
  # get 'products/new'
  # get 'products/create'
  # get 'products/edit'
  # get 'products/destroy'
  resources :categories, only: [ :new, :create, :index ] do
    resources :products, only: [:index, :new]
  end
  # get 'categories/new'
  # get 'categories/create'
  resources :orders, only: [ :new, :create, :show ]
  # get 'orders/new'
  # get 'orders/create'
  # get 'orders/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
