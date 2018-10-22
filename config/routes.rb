Rails.application.routes.draw do
  root 'products#root'

  get "/auth/:provider/callback", to: "sessions#login", as: "auth_callback"

  # resources :orders, only: [:show, :new, :create, :index]

  resources :sessions, only: [ :login, :destroy, :new ]
  # get 'sessions/login'
  # get 'sessions/destroy'
  # get 'sessions/new'
  resources :users, only: [ :new, :create, :show, :index]
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
  resources :orders, only: [:show, :new, :create, :index] do
  resources :orders_items, only: [:create, :new, :show]
end
 post '/products/:id/add_to_cart', to: "products#add_to_cart", as: "add_to_cart"


  # get '/order/:id/orders_items', to: 'orders_items#index'
  # get '/order/:id/orders_items', to: 'orders_items#new'
  # post '/order/:id/orders_items', to: 'orders_items#create'



end
