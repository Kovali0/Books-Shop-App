Rails.application.routes.draw do

  devise_for :users, :path_prefix => 'd'
  resources :users, :only =>[:show]

  get 'users/index'
  match '/users',   to: 'users#index',   via: 'get'
  match '/users/:id',     to: 'users#show',       via: 'get'

  root 'application#mainpage'

end
