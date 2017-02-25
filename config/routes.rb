Rails.application.routes.draw do
  post 'friendships/create'

  get 'friendships/destroy'

  resources :messages
  resources :sessions, only: [:new, :create]
  resources :users
  root "home#index"
  delete 'log_out' => 'sessions#destroy'
end
