Rails.application.routes.draw do
  get 'welcome/index'

  resources :recipes


  root to: 'welcome#index' #main home webpage
  get "welcome/index"
  get "users/new"

	get "logout" => "sessions#destroy"

  resources :sessions

  resources :users do
    member do
      get :home
      get :my_recipes
      post :save_recipe
    end
    collection do

    end
  end

end
