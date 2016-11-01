class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.integer :role
      t.integer :preference_id
      t.integer :savedrecipe_id
      t.timestamps
    end
  end
end
