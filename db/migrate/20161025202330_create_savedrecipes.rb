class CreateSavedrecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :savedrecipes do |t|

      t.timestamps
    end
  end
end
