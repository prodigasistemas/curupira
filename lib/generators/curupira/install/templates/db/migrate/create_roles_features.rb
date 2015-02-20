class CreateRolesFeatures < ActiveRecord::Migration
  def self.up
    create_table :roles_features, :id => false do |t|
      t.column :role_id, :integer, :null => false
      t.column :feature_id, :integer, :null => false
    end
    add_index :role_features, [:role_id, :feature_id], :unique => true, :name => :roles_features_ids
  end

  def self.down
    drop_table :roles_features
  end
end