Rails.application.routes.draw do
  get 'reactions/create'
  get 'reactions/destroy'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: "posts#index"

  resources :reactions, only: %i[create destroy]
  resources :friendships
  resources :users do
    resources :profiles
    get :notifications
  end
  
  resources :posts do 
    resources :comments, only: %i[create destroy]
  end  
end
