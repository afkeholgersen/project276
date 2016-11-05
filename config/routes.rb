Rails.application.routes.draw do

  resources :recipes
  get "logout" => "sessions#destroy"


  resources :users do
    member do
      get :home
      get :my_recipes
      post :save_recipe
    end
    collection do

    end
  end
  resources :sessions
  root "users#index"
end
