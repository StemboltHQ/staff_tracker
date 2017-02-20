Rails.application.routes.draw do
  resources :people
  resources :presentations

  root 'welcome#index'
end
