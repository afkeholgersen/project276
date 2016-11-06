Rails.application.routes.draw do
  get 'welcome/index'



  root to: 'welcome#index' #main home webpage
  get "welcome/index"
  get "users/new"

	get "logout" => "sessions#destroy"

  resources :sessions
  resources :users
end
