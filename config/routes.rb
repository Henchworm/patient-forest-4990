Rails.application.routes.draw do

  get '/studios', to: 'studios#index'

  get "/movies/:id", to: 'movies#show'
  patch "/movies/:id", to: 'movies#update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
