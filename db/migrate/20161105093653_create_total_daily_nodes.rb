class CreateTotalDailyNodes < ActiveRecord::Migration[5.0]
  def change
    create_table :total_daily_nodes do |t|
      t.string :label
      t.string :quantity
      t.string :unit
      t.string :node_label
      t.integer :recipe_id

      t.timestamps
    end
  end
end
