class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :name
      t.string :controller
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
