Rails.application.routes.draw do
  namespace :api do
    resources :clearance_batches, only: [:index,:create,:show,:update]
    resources :items, only: [:index,:show,:update]
    resources :type, only: [:index,:show,:update]
  end
  root 'home#index'
  resources :clearance_batches, only: [:index]
end
