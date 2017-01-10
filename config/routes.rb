Rails.application.routes.draw do
  root :to => 'welcome#index'
  resources 'politicians', only: [:index]
  resources :outings, only: [:index, :show]
  resources :users, only: [:new, :create, :edit, :update]
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
    resources :outings, only: [:index, :edit, :update]
    post '/makes_admin' => 'users#make_admin', :as => 'makes_admin'
    get '/dashboard' => 'base#dashboard'
  end
  post '/order_cancel' => 'orders#cancel', :as => 'cancel'
  post '/order_paid' => 'orders#paid', :as => 'paid'
  post '/order_completed' => 'orders#completed', :as => 'completed'
end
