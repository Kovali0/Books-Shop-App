Rails.application.routes.draw do

  resources :order_items
  get 'cart', to: 'cart#show'

  resources :categories
  resources :comments
  resources :products
  match '/newest',   to: 'products#newest', via: 'get'
  match '/toprating',   to: 'products#toprating', via: 'get'

  devise_for :users, :path_prefix => 'd'
  resources :users, :only =>[:show]
  get 'users/index'
  match '/users',   to: 'users#index',   via: 'get'
  match '/users/:id',     to: 'users#show',       via: 'get'

  root 'products#home'

end
