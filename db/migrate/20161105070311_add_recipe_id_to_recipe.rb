class AddRecipeIdToRecipe < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :recipe_id, :string
  end
end
