module RecipesHelper
  def saved_already(user,uri)
    recipe = user.recipes.where(recipe_id:uri).first
    recipe.blank?
  end

end
