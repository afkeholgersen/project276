class CreateIngredients < ActiveRecord::Migration[5.0]
  def change
    create_table :ingredients do |t|
      t.text :text
      t.string :quantity
      t.string :measure
      t.string :food
      t.string :weight
      t.integer :recipe_id

      t.timestamps
    end
  end
end
