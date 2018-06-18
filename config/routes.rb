Rails.application.routes.draw do
  get 'password_reset/new'
  get 'password_reset/edit'
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

  get '/password_reset', to: 'password_reset#new'

  #Test mailers
  get '/mailer', to: 'user_mailer#account_activation'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  resources :users
  resources :accounts
  resources :account_activations, only: [:edit]
  resources :password_reset, only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
end
