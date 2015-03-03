class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.belongs_to :role, index: true
      t.belongs_to :group_user, index: true

      t.timestamps null: false
    end
    add_foreign_key :authorizations, :group_users
    add_foreign_key :authorizations, :roles
  end
end
