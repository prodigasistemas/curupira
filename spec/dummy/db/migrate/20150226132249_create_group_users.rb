class CreateGroupUsers < ActiveRecord::Migration
  def change
    create_table :group_users do |t|
      t.belongs_to :user, index: true
      t.belongs_to :user_group, index: true

      t.timestamps null: false
    end
    add_foreign_key :group_users, :users
    add_foreign_key :group_users, :user_groups
  end
end
