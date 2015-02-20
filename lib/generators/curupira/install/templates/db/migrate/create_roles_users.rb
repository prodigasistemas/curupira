class CreateRolesUsers < ActiveRecord::Migration
  def self.up
    create_table :roles_users, :id => false do |t|
      t.column :role_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
    end
    add_index :role_users, [:role_id, :user_id], :unique => true, :name => :roles_users_ids
  end

  def self.down
    drop_table :roles_users
  end
end