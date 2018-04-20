Rails.application.routes.draw do
  resources :orders
  resources :orders, only: [:index, :new, :create]
end
