class CreateActionLabels < ActiveRecord::Migration
  def change
    create_table :action_labels do |t|
	  t.string :name
      t.boolean :active
      
      t.timestamps null: false
    end
  end
end
