Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'outings#index'
  resources 'politicians', only: [:index]
  resources :outings, only: [:index]
  resources :users, only: [:new, :create]
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/dashboard' => 'users#show'
  get '/cart' => 'carts#index'
  post '/cart_increment' => 'carts#increment', :as => 'increment'
  post '/cart_decrement' => 'carts#decrement', :as => 'decrement'
  get '/:name' => 'politicians#show', :as => 'categories'
  resources :carts, only: [:create, :destroy]
end
