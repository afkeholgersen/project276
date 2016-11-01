class CreateHealthlabels < ActiveRecord::Migration[5.0]
  def change
    create_table :healthlabels do |t|

      t.timestamps
    end

    create_table :healthlabels_preferences do |t|
    	t.belongs_to :preference, index: true
    	t.belongs_to :healthlabel, index: true
    end

  end
end
