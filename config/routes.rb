Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'authentication#google'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'authentication/google', to: 'authentication#google'

  resources :sessions, only: [:destroy]
  resources :people
  resources :events, only: [:show, :create, :new, :upcoming] do
    get "/upcoming-events", to: 'events#upcoming', on: :collection
  end
  resources :presentations, only: [:show, :create, :new]

  root 'welcome#index'
end
