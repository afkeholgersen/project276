class AddFieldsToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :recipe_name, :string
    add_column :recipes, :health_labels, :string
    add_column :recipes, :diet_labels, :string
    add_column :recipes, :image_url, :string
  end
end
