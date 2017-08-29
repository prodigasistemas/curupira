class CreateFeatures < <%= migration_class_name %>
  def change
    create_table :features do |t|
      t.string :name
      t.string :controller
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
