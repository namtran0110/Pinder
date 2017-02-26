Rails.application.routes.draw do
  post 'friendships/create'

  get 'friendships/destroy'

  resources :messages do
    collection do
      get :sent
      get :received
    end
  end
  resources :sessions, only: [:new, :create]
  resources :users
  root "home#index"
  delete 'log_out' => 'sessions#destroy'
end
