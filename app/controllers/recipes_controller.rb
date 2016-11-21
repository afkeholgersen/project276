class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
    @user = User.find_by(id: session[:user_id])

    
  end
end
