require 'rails_helper'
require "generators/curupira/install/install_generator"

describe Curupira::Generators::InstallGenerator, :generator do
  before do
    provide_existing_routes_file
  end

  describe "role_group_user_model" do
    context "no existing role_group_user class" do
      it "generates role_group_user" do
        run_generator
        authorization_class = file("app/models/role_group_user.rb")

        expect(authorization_class).to exist
        expect(authorization_class).to have_correct_syntax
        expect(authorization_class).to contain("belongs_to :group_user")
        expect(authorization_class).to contain("belongs_to :role")
      end
    end

    context "role_group_user class already exists" do
      it "includes validations" do
        provide_existing_class("role_group_user")

        run_generator
        authorization_class = file("app/models/role_group_user.rb")

        expect(authorization_class).to exist
        expect(authorization_class).to have_correct_syntax
        expect(authorization_class).to contain("belongs_to :group_user")
        expect(authorization_class).to contain("belongs_to :role")
      end
    end
  end

  describe "role_group_user migration" do
    context "role_group_users table does not exist" do
      it "creates a migration to create the role_group_user table" do
        allow(ActiveRecord::Base.connection).to receive(:table_exists?).and_return(false)

        run_generator
        migration = migration_file("db/migrate/create_role_group_users.rb")
        
        expect(migration).to exist
        expect(migration).to have_correct_syntax
        expect(migration).to contain("create_table :role_group_users")
      end
    end
  end
end