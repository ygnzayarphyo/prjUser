Rails.application.routes.draw do
  get '/login', to: 'sessions#login'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get 'users/new'
  get '/home',to: 'static_pages#home'
  get '/help',to:  'static_pages#help'

  get '/about',to:  'static_pages#about'
  get '/contact',to:  'static_pages#contact'
  get '/news',to:  'static_pages#news'
  get '/signup',  to: 'accounts#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  resources :users
  resources :accounts
  resources :account_activations, only: [:edit]
end
