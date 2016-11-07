class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|

      t.timestamps
    end

    create_table :recipes_savedrecipes do |t|
    	t.belongs_to :savedrecipe, index: true
    	t.belongs_to :recipe, index: true
    end
    
  end
end
