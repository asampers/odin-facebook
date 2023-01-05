Rails.application.routes.draw do
  get 'friendships/index'
  get 'friendships/show'
  get 'friendships/new'
  get 'friendships/create'
  get 'friendships/destroy'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  
  root to: "posts#index"

  resources :users do 
    resources :friendships
  end  
  resources :posts
end
