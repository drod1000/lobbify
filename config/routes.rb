Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :outings, only: [:index]
  get '/cart' => 'carts#index'
  # post '/cart' => 'carts#remove_outing'
  # post '/cart' => 'carts#destroy'
  resources :carts, only: [:create, :destroy]

end
