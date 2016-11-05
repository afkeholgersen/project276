Rails.application.routes.draw do

	get "logout" => "sessions#destroy"


  resources :users do
    member do
      get :home
    end
    collection do

    end
  end
  resources :sessions
  root "users#index"
end
