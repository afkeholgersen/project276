Rails.application.routes.draw do
  get 'welcome/index'

  resources :users

  root to: 'welcome#index' #main home webpage
  get "welcome/index"
  get "users/new"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
