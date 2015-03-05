class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.belongs_to :feature, index: true
      t.belongs_to :role, index: true

      t.timestamps null: false
    end
    add_foreign_key :authorizations, :features
    add_foreign_key :authorizations, :roles
  end
end
