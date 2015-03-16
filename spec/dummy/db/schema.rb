# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150312183617) do

  create_table "action_labels", force: :cascade do |t|
    t.string   "name"
    t.integer  "feature_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "action_labels", ["feature_id"], name: "index_action_labels_on_feature_id"

  create_table "authorizations", force: :cascade do |t|
    t.integer  "feature_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authorizations", ["feature_id"], name: "index_authorizations_on_feature_id"
  add_index "authorizations", ["role_id"], name: "index_authorizations_on_role_id"

  create_table "feature_action_labels", force: :cascade do |t|
    t.integer  "feature_id"
    t.integer  "action_label_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "feature_services", force: :cascade do |t|
    t.integer  "feature_id"
    t.integer  "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "features", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active",     default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "group_users", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "group_users", ["group_id"], name: "index_group_users_on_group_id"
  add_index "group_users", ["user_id"], name: "index_group_users_on_user_id"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "role_group_users", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "group_user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "role_group_users", ["group_user_id"], name: "index_role_group_users_on_group_user_id"
  add_index "role_group_users", ["role_id"], name: "index_role_group_users_on_role_id"

  create_table "role_groups", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "group_id"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "role_groups", ["group_id"], name: "index_role_groups_on_group_id"
  add_index "role_groups", ["role_id"], name: "index_role_groups_on_role_id"

  create_table "roles", force: :cascade do |t|
    t.string  "name",                  null: false
    t.boolean "active", default: true
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                                          null: false
    t.string   "name",                                           null: false
    t.boolean  "active",                          default: true
    t.string   "username"
    t.string   "crypted_password"
    t.string   "salt"
    t.string   "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.datetime "last_login_at"
    t.datetime "last_logout_at"
    t.datetime "last_activity_at"
    t.string   "last_login_from_ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["last_activity_at"], name: "index_users_on_last_activity_at"
  add_index "users", ["last_logout_at"], name: "index_users_on_last_logout_at"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token"
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
