require 'rails_helper'
require "generators/curupira/install/install_generator"

describe Curupira::Generators::InstallGenerator, :generator do

  before do
    provide_existing_routes_file
  end

  describe "sorccery initializer" do
    it "is copied to the application" do
      run_generator
      initializer = file("config/initializers/sorcery.rb")

      expect(initializer).to exist
      expect(initializer).to have_correct_syntax
      expect(initializer).to contain("Rails.application.config.sorcery.configure do |config|")
    end
  end

  describe "group" do
    context "no existing user group class" do
      it "generates group" do
        run_generator

        group = file("app/models/group.rb")

        expect(group).to exist
        expect(group).to contain("validates_presence_of :name")
        expect(group).to contain("has_many :role_groups")
        expect(group).to contain("has_many :roles, through: :role_groups")
        expect(group).to contain("accepts_nested_attributes_for :role_groups, reject_if: :all_blank, allow_destroy: :true")
        expect(group).to contain("scope :active, -> { where active: true }")
      end
    end

    context "group class already exists" do
      it "includes validations" do
        run_generator
        group = file("app/models/group.rb")

        expect(group).to exist
        expect(group).to have_correct_syntax
        expect(group).to contain("validates_presence_of :name")
        expect(group).to contain("has_many :role_groups")
        expect(group).to contain("has_many :roles, through: :role_groups")
        expect(group).to contain("accepts_nested_attributes_for :role_groups, reject_if: :all_blank, allow_destroy: :true")
        expect(group).to contain("scope :active, -> { where active: true }")
      end
    end
  end

  describe "group migration" do
    context "group table does not exist" do
      it "creates a migration to create the group table" do
        allow(ActiveRecord::Base.connection).to receive(:table_exists?).and_return(false)

        run_generator
        migration = migration_file("db/migrate/create_groups.rb")

        expect(migration).to exist
        expect(migration).to have_correct_syntax
        expect(migration).to contain("create_table :groups")
      end
    end
  end

  describe "user_model" do
    context "no existing user class" do
      it "creates a user class Curupira configurations" do
        run_generator
        user_class = file("app/models/user.rb")

        expect(user_class).to exist
        expect(user_class).to have_correct_syntax
        expect(user_class).to contain("authenticates_with_sorcery!")
        expect(user_class).to contain("validates_presence_of :email")
        expect(user_class).to contain("has_many :group_users")
        expect(user_class).to contain("has_many :groups, through: :group_users")
        expect(user_class).to contain("has_many :role_group_users, through: :group_users")
        expect(user_class).to contain("accepts_nested_attributes_for :group_users, reject_if: :all_blank, allow_destroy: :true")
        expect(user_class).to contain("scope :all_belonging_to, -> (user) { includes(group_users: :group).where(groups: { id: user.groups }) }")
      end
    end

    context "user class already exists" do
      it "includes Curupira configurations" do
        provide_existing_user_class

        run_generator
        user_class = file("app/models/user.rb")

        expect(user_class).to exist
        expect(user_class).to have_correct_syntax
        expect(user_class).to contain("authenticates_with_sorcery!")
        expect(user_class).to contain("validates_presence_of :email")
        expect(user_class).to contain("has_many :group_users")
        expect(user_class).to contain("has_many :groups, through: :group_users")
        expect(user_class).to contain("has_many :role_group_users, through: :group_users")
        expect(user_class).to contain("accepts_nested_attributes_for :group_users, reject_if: :all_blank, allow_destroy: :true")
        expect(user_class).to contain("scope :all_belonging_to, -> (user) { includes(group_users: :group).where(groups: { id: user.groups }) }")
      end
    end
  end

  describe "user migration" do
    context "users table does not exist" do
      it "creates a migration to create the users table" do
        allow(ActiveRecord::Base.connection).to receive(:table_exists?).and_return(false)

        run_generator
        migration = migration_file("db/migrate/sorcery_core.rb")

        expect(migration).to exist
        expect(migration).to have_correct_syntax
        expect(migration).to contain("create_table :users")
      end
    end

    context "existing users table with all curupira columns and indexes" do
      it "does not create a migration" do
        run_generator
        create_migration = migration_file("db/migrate/sorcery_core.rb")
        add_migration = migration_file("db/migrate/add_curupira_to_users.rb")

        expect(create_migration).not_to exist
        expect(add_migration).not_to exist
      end
    end

    context "existing users table missing some columns and indexes" do
      it "create a migration to add missing columns and indexes" do
        Struct.new("Named", :name)
        existing_columns = [Struct::Named.new("username")]
        existing_indexes = [Struct::Named.new("index_users_on_username")]

        allow(ActiveRecord::Base.connection).to receive(:columns).
          with(:users).
          and_return(existing_columns)

        allow(ActiveRecord::Base.connection).to receive(:indexes).
          with(:users).
          and_return(existing_indexes)

        run_generator
        migration = migration_file("db/migrate/add_curupira_to_users.rb")

        expect(migration).to exist
        expect(migration).to have_correct_syntax
        expect(migration).to contain("change_table :users")
        expect(migration).to contain("t.string :email")
        expect(migration).to contain("add_index :users, :reset_password_token")
        expect(migration).not_to contain("t.string :username")
        expect(migration).not_to contain("add_index :users, :index_users_on_username")
        expect(migration).to contain("t.boolean :admin, default: false")
      end
    end
  end
end
