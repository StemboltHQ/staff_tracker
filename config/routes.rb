Rails.application.routes.draw do
  resources :people
  resources :events, only: [:show, :create, :new] do
    get 'upcoming', to: 'events#upcoming', on: :collection
  end
  resources :presentations, only: [:show, :create, :new]

  root 'welcome#index'
end
