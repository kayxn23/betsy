Rails.application.routes.draw do
  root 'products#root'



  get "/auth/:provider/callback", to: "sessions#login", as: "auth_callback"
  delete "/logout", to: "sessions#destroy", as: "logout"
  get "users/:id/dashboard", to: "users#dashboard", as: "dashboard"
  get "users/:user_id/products", to: "users#products", as: "merchant_products"
  # resources :orders, only: [:show, :new, :create, :index]

  # get 'sessions/login'
  # get 'sessions/destroy'
  # Might not need new/create/show
  # Oauth does new/create, show is dashboard
  resources :users, only: [ :new, :create, :index]

# Creates route for user_products so we can link each merchant to
# users/:user_id/products
  # resources :users, only: [:show] do
  #   resources :products, only: [:index]
  # end

  # TODO Added nested routes for orderitems
  get '/sessions/current_order', to: "sessions#current_order", as: "current_order"
  # get 'users/new'
  # get 'users/create'
  # get 'users/show'
  resources :products, except: [:destroy] do
    post 'retire', to: "products#retire", as: "retire"
    post 'add_to_cart', to: "products#add_to_cart", as: "add_to_cart"
  end

  # get '/products', to: 'products#index', as: 'products'
  # get '/products/:id', to: 'products#show', as: 'product'

  resources :categories, only: [ :new, :create, :index , :show]

  # get 'categories/new'
  # get 'categories/create'
  resources :orders, only: [:show, :new, :create, :index, :update, :edit] do
  resources :orders_items, only: [:create, :new, :show, :destroy]
end



  # get '/order/:id/orders_items', to: 'orders_items#index'
  # get '/order/:id/orders_items', to: 'orders_items#new'
  # post '/order/:id/orders_items', to: 'orders_items#create'



end
