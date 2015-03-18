class CreateRoleGroupUsers < ActiveRecord::Migration
  def change
    create_table :role_group_users do |t|
      t.belongs_to :role, index: true
      t.belongs_to :group_user, index: true

      t.timestamps null: false
    end
    add_foreign_key :authorizations, :group_users
    add_foreign_key :authorizations, :roles
  end
end
