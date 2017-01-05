Rails.application.routes.draw do
  resources 'politicians', only: [:index]
  get 'outings' => 'outings#index'
end
