Rails.application.routes.draw do

	get "logout" => "sessions#destroy"

  resources :users
  resources :sessions
 
end
