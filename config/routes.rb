Rails.application.routes.draw do

  get 'password_resets/new'

  get 'welcome/index'
  get 'creator', controller: :welcome, action: :creator
  get 'about', controller: :welcome, action: :about
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
  
  resources :password_resets

  resources :users do

    member do
      get :home
      get :my_recipes
      get :individual_recipes
      get :all_recipes
      post :save_recipe
      post :save_recipeOnly
      delete :deleteuser
      delete :unsave_recipe
    end

    collection do

    end
  end
end
