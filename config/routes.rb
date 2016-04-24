Rails.application.routes.draw do
  namespace :api do
    resources :clearance_batches, only: [:index,:create,:show,:edit,:update]
    resources :items, only: [:index,:show,:edit,:update]
    resources :style, only: [:index]
    resources :type, only: [:index,:show,:edit,:update]
  end
  root 'home#index'
end
