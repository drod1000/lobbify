Rails.application.routes.draw do
  root :to => 'outings#index'
  resources 'politicians', only: [:index]
  resources :outings, only: [:index, :show]
  resources :users, only: [:new, :create]
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  get '/dashboard' => 'users#show'
  get '/cart' => 'carts#index'
  post '/cart_increment' => 'carts#increment', :as => 'increment'
  post '/cart_decrement' => 'carts#decrement', :as => 'decrement'
  resources :orders, only: [:index, :show]
  post '/orders' => 'orders#create', :as => 'checkout'
  get '/:name' => 'politicians#show', :as => 'categories'
  resources :carts, only: [:create, :destroy]
  namespace :admin do
    resources :users, only: [:index]
    post '/makes_admin' => 'users#make_admin', :as => 'makes_admin'
  end
end
