class CreateAuthorizations < <%= migration_class_name %>
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
