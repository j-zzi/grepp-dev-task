Rails.application.routes.draw do
  post '/auth/login', to: 'auth#login'
  delete '/auth/logout', to: 'auth#logout'
  post '/auth/register', to: 'auth#register'
end
