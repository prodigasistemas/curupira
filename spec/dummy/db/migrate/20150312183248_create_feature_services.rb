class CreateFeatureServices < ActiveRecord::Migration
  def change
    create_table :feature_services do |t|
      t.belongs_to :feature
      t.belongs_to :service

      t.timestamps null: false
    end
  end
end
