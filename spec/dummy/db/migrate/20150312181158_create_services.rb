class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.boolean :active
      		
      t.timestamps null: false
    end
  end
end
