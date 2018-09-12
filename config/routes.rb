Rails.application.routes.draw do
  root 'users#index'
  resources :users
  resources :events

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'events/:id/RSVP', to: 'events#join', as: 'join_event'
  delete 'events/:id/RSVP', to: 'events#leave', as: 'leave_event'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
