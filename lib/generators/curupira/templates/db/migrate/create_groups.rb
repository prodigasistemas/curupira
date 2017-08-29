class CreateGroups < <%= migration_class_name %>
  def change
    create_table :groups do |t|
      t.string :name
      t.boolean :active

      t.timestamps null: false
    end
  end
end
