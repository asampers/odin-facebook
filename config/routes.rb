Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root to: "posts#index", defaults: { format: 'html' } 

  get 'users/:user_id/notifications/delete', to: 'notifications#destroy_multiple', as: :destroy_multiple

  resources :reactions, only: %i[create destroy]
  resources :friendships
  resources :users do
    resources :profiles
    get :notifications
  end
  
  resources :notifications, only: %i[destroy]
  resources :posts do 
    resources :comments, only: %i[new create destroy]
    get 'reactions', to: 'reactions#index'
  end 
end
