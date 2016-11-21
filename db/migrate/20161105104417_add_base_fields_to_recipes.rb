class AddBaseFieldsToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :dietLabels, :text
    add_column :recipes, :healthLabels, :text
    add_column :recipes, :source, :string
    add_column :recipes, :sourceIcon, :string
    add_column :recipes, :title, :string
  end
end
