Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'authentication#google'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'authentication/google', to: 'authentication#google'

  get 'sign_in', to: 'welcome#sign_in', as: 'sign_in'

  resources :sessions, only: [:destroy]
  resources :people
  resources :events, only: [:show, :create, :new] do
    get 'upcoming', to: 'events#upcoming', on: :collection
  end
  resources :presentations

  root 'welcome#index'
end
