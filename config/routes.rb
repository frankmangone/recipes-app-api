Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :ingredients, only: [:index, :show, :create]
  resources :recipes, only: [:index, :show, :create]
  
  post 'login', to: 'authentication#login'
  post 'refresh_token', to: 'authentication#refresh_token'
end
