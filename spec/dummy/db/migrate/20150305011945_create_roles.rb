class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string   :name,   null: false
      t.boolean  :active, default: true
    end
  end
end