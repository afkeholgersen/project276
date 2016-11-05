class CreateIngredientLines < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredient_lines do |t|
      t.text :text
      t.integer :recipe_id

      t.timestamps
    end
  end
end
