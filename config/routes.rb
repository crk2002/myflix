Myflix::Application.routes.draw do
  root to: 'static_pages#front'
  resources :videos, only: [:show, :index] do
      get 'search', on: :collection
  end
  get '/categories/:id', to: 'categories#show', as: 'category'
  get '/register', to: 'users#new', as: 'register'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users, only: [:create, :show]
end
