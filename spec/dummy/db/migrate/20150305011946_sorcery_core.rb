class SorceryCore < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :email,                            null: false
      t.string   :name,                             null: false
      t.boolean  :active,                           default: true
      t.string   :username
      t.string   :crypted_password
      t.string   :salt
      t.string   :reset_password_token,             default: nil
      t.datetime :reset_password_token_expires_at,  default: nil
      t.datetime :reset_password_email_sent_at,     default: nil
      t.datetime :last_login_at,                    default: nil
      t.datetime :last_logout_at,                   default: nil
      t.datetime :last_activity_at,                 default: nil
      t.string   :last_login_from_ip_address,       default: nil
      t.boolean  :admin,                            default: false

      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :reset_password_token
    add_index :users, :last_logout_at
    add_index :users, :last_activity_at
  end
end
