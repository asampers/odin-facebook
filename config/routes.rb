Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root to: "posts#index"

  resources :friendships
  resources :users do
    resources :friendships
    resource :profile
    get :notifications
  end

  resources :posts do 
    resources :comments, only: %i[create destroy]
  end  
end
