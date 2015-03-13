class CreateFeatureActionLabels < ActiveRecord::Migration
  def change
    create_table :feature_action_labels do |t|
      t.belongs_to :feature
      t.belongs_to :action_label

      t.timestamps null: false
    end
  end
end
