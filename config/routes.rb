Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'authentication#google'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'authentication/google', to: 'authentication#google'
  match '/403', to: 'errors#forbidden', via: :all

  resources :sessions, only: [:destroy]
  resources :people
  resources :events do
    resources :presentations, only: [:new, :edit]
    get 'upcoming', to: 'events#upcoming', on: :collection
  end
  resources :presentations, except: [:edit] do
    get 'requests', to: 'topic_requests#index', on: :collection
  end
  resources :topic_requests, only: [:create]

  root 'welcome#index'
end
