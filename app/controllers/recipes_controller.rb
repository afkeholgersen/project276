class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
    @user = User.find_by(id: session[:user_id])
    @comment = Comment.new(comment_params)
  end
end
