Rails.application.routes.draw do
  resources :clearance_batches, only: [:index, :create]
  resources :items, only: [:index]
  resources :style, only: [:index]
  root 'home#index'
end
