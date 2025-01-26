Rails.application.routes.draw do
  resources :users, only: [:create]

  resources :auth, only: [], controller: 'authentication' do
    collection do
      post 'login', action: :authenticate
    end
  end

  resources :reservations, only: [:index, :create, :update, :destroy]

  resources :tests, only: :index

  namespace :admin do
    resources :reservations, only: [:index, :update] do
      member do
        patch :confirm
        patch :reject
      end
    end
    resources :tests, only: [:create, :destroy]
  end
end
