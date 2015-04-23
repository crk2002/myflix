Myflix::Application.routes.draw do
  root to: 'videos#index'
  get '/videos/:id', to: 'videos#show', as: 'video'
  get '/categories/:id', to: 'categories#show', as: 'category'
  get 'ui(/:action)', controller: 'ui'
end
