Rails.application.routes.draw do
  resources 'politicians', only: [:index]
end
