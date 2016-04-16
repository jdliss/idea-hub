Rails.application.routes.draw do
  root to: 'ideas#welcome'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: "sessions#destroy"
  get '/users/:user_id/ideas', to: "users#ideas"

  resources :users do
    resources :ideas, except: [:index]
  end

  namespace :admin do
    resources :categories
  end

  resources :ideas
end
