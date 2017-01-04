Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :outings, only: [:index]
  get '/cart' => 'carts#index'
  resources :carts, only: [:create]
end
