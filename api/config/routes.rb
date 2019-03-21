Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/ratings', to: 'ratings#create'
  get '/ratings', to: 'ratings#index'
  get '/ratings/:name', to: 'ratings#show'
end
