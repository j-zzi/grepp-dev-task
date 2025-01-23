Rails.application.routes.draw do
  post 'signup', to: 'user#create'
end
