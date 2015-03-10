class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :description
      t.string :controller
      t.string :action
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
