class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :role, index: true
      t.belongs_to :group, index: true

      t.timestamps null: false
    end
    add_foreign_key :authorizations, :users
    add_foreign_key :authorizations, :roles
    add_foreign_key :authorizations, :groups
  end
end
