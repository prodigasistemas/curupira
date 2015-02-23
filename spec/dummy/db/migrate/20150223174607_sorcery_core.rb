class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :email,               null: false
      t.string  :name,                null: false
      t.boolean :active,              default: true
      t.string  :username
      t.string  :crypted_password
      t.string  :salt

      t.timestamps
    end

    add_index :users, :username, unique: true
  end
end
