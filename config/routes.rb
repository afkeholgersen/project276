Rails.application.routes.draw do

  get 'welcome/index'
  get "users/adminhome"

  resources :recipes do
    member do
      post :createComment
      get :deleteComment
    end
  end


  root to: 'welcome#index' #main home webpage

  get "users/new"
	get "logout" => "sessions#destroy"
  get "users/search"

  resources :sessions

  resources :users do

    member do
      get :home
      
      get :my_recipes
      get :individual_recipes
      get :all_recipes
      post :save_recipe
      post :save_recipeOnly
      delete :unsave_recipe
      delete :deleteuser
    end
    
    collection do

    end
  end
end
