class CreateActionLabels < ActiveRecord::Migration
  def change
    create_table :action_labels do |t|
      t.string :name
      t.belongs_to :feature, index: true
      t.boolean :active, default: true
      
      t.timestamps null: false
    end
    add_foreign_key :action_labels, :features
  end
end
