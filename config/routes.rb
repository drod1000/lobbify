Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'outings#index'
  resources 'politicians', only: [:index]
  resources :outings, only: [:index]
  get '/cart' => 'carts#index'
  post '/cart_increment' => 'carts#decrement', :as => 'decrement'
  post '/cart_decrement' => 'carts#increment', :as => 'increment'
  get '/:name' => 'politicians#show', :as => 'categories'
  resources :carts, only: [:create, :destroy]
end
