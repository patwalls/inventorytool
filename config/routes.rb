Rails.application.routes.draw do
  resources :clearance_batches, only: [:index, :create]
  root 'home#index'
end
