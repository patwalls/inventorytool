Rails.application.routes.draw do
  namespace :api do
    resources :clearance_batches, only: [:index,:create]
    resources :items, only: [:index,:show,:edit,:update]
    resources :style, only: [:index]
  end
  root 'home#index'
end
