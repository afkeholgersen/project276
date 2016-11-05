class AddBaseFieldsToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :share_as, :string
    add_column :recipes, :dietLabels, :text
    add_column :recipes, :healthLabels, :text
    add_column :recipes, :cautions, :text
    add_column :recipes, :source, :string
    add_column :recipes, :sourceIcon, :string
    add_column :recipes, :yield, :string
    add_column :recipes, :calories, :string
    add_column :recipes, :totalWeight, :string
  end
end
