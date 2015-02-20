class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features  do |t|
      t.string :description, null: false
      t.string :controller, null: false
      t.string :action, null: false

      t.timestamps null: false
    end
    
    add_index :features, :description
  end
end