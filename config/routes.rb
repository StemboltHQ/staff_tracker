Rails.application.routes.draw do
  resources :people
  resources :events, only: [:show, :create, :new]
  resources :presentations, only: [:show, :new]

  root 'welcome#index'
end
