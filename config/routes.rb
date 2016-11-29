Rails.application.routes.draw do

  get 'welcome/index'
  get "users/adminhome"
  resources :recipes


  root to: 'welcome#index' #main home webpage

  get "users/new"
	get "logout" => "sessions#destroy"

  resources :sessions

  resources :users do

    member do
      get :home
      get :search
      get :my_recipes
      get :individual_recipes
      post :save_recipe
      delete :unsave_recipe
      delete :deleteuser
    end
    
    collection do

    end
  end
end
