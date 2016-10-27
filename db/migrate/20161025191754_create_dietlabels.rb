class CreateDietlabels < ActiveRecord::Migration[5.0]
  def change
    create_table :dietlabels do |t|

      t.timestamps
    end

    create_table :dietlabels_preferences do |t|
    	t.belongs_to :preference, index: true
    	t.belongs_to :dietlabel, index: true
    end

  end
end
