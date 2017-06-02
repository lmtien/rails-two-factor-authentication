Rails.application.routes.draw do
  # resources :tfas
  # resources :users

  root 'users#login'
  get 'index' => 'users#login'
  
  get 'login' => 'users#login'
  post 'login' => 'users#authenticate'
  
  get 'sign_up' => 'users#new'
  post 'sign_up' => 'users#create'
  
  get 'verify' => 'tfas#verify_2fa'
  post 'verify' => 'tfas#verify_2fa_code'
end
