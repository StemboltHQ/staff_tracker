Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'authentication#google'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'authentication/google', to: 'authentication#google'

  resources :sessions, only: [:destroy]
  resources :people
  resources :events do
    resources :presentations, only: [:new, :edit]
    get 'upcoming', to: 'events#upcoming', on: :collection
  end
  resources :presentations, except: [:edit]

  root 'welcome#index'
end
