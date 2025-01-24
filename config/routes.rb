Rails.application.routes.draw do
  post 'signup', to: 'user#create'
  post 'auth/login', to: 'authentication#authenticate'
end
