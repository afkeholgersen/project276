class RecipesController < ApplicationController
  def show
    @recipe = Recipe.find(params[:id])
        #@comment = Comment.new(comment_params)
  end

  def create
    #u = User.find_by(id: session[:user_id])
    @recipe = Recipe.find(params[:commit].id)
    @comment = Comment.new(:comment_text => params[:comment_text], :vote => params[:vote])
    current_user.comments.push(@comment)
    @recipe.comments.push(@comment)
    @comment.user = current_user
    @comment.recipe = @recipe
    @comment.save
  end


end
