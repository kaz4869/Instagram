Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show] do
    resources :relationships, only: [:create, :destroy]
  end
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]

  resources :posts do
    resources :comments, only: [:create, :destroy] do
      resources :comment_likes, only: [:create, :destroy] 
    end
    resources :post_likes, only: [:create, :destroy]
  end

  root 'posts#index'
end
