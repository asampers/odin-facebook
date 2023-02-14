Rails.application.routes.draw do

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: "posts#index"

  resources :reactions, only: %i[create destroy]
  resources :friendships
  resources :users do
    resources :profiles
    get :notifications
  end
  
  resources :posts do 
    resources :comments, only: %i[new create destroy]
    get 'reactions', to: 'reactions#index'
  end  
end
