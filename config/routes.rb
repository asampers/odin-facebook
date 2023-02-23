Rails.application.routes.draw do
  get 'notifications/destroy'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  root "posts#index"

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
