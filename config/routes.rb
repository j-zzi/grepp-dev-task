Rails.application.routes.draw do
  resources :users, only: [:create]

  resources :auth, only: [], controller: 'authentication' do
    collection do
      post 'login', action: :authenticate
    end
  end

  resources :reservations, only: [:index, :create, :update, :destroy]

  resources :tests, only: [:index, :create, :destroy], controller: 'test'
end