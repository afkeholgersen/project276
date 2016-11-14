class AddUserIdToPreference < ActiveRecord::Migration[5.0]
  def change
    add_column :preferences, :user_id, :integer
  end
end
