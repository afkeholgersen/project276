Rails.application.routes.draw do
  get 'welcome/index'

  resources :users

  root to: 'welcome#index' #main home webpage
  get "welcome/index"
  get "users/new"

	get "logout" => "sessions#destroy"

  resources :sessions

end
