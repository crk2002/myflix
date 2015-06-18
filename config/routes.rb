Myflix::Application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  root to: 'static_pages#front'
  resources :videos, only: [:show, :index] do
      get 'search', on: :collection
      resources :reviews, only: [:create]
  end
  resources :followings, only: [:index, :create, :destroy]
  resources :reset_password_requests, only: [:new, :create, :edit, :update]
  resources :invites, only: [:new, :create]
  get '/register/:token', to: 'users#new_with_invite', as: 'register_with_invite'
  get '/categories/:id', to: 'categories#show', as: 'category'
  get '/register', to: 'users#new', as: 'register'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post 'my_queue', to: "queue_entries#update", as: :update_user_queue
  get 'my_queue', to: "queue_entries#index", as: :user_queue
  resources :users, only: [:create, :show]
  resources :queue_entries, only: [:create, :destroy]
end
