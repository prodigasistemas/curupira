class CreateGroupUsers < ActiveRecord::Migration
  def change
    create_table :group_users do |t|
      t.belongs_to :group, index: true
      t.belongs_to :user, index: true
      t.boolean :active

      t.timestamps null: false
    end
    add_foreign_key :group_users, :groups
    add_foreign_key :group_users, :users
  end
end