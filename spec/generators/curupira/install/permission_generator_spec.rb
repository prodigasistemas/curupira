require 'rails_helper'
require "generators/curupira/install/install_generator"

describe Curupira::Generators::InstallGenerator, :generator do
  before do
    provide_existing_routes_file
  end

  describe "permission_model" do
    context "no existing permission class" do
      it "generates permission" do
        run_generator
        authorization_class = file("app/models/permission.rb")

        expect(authorization_class).to exist
        expect(authorization_class).to have_correct_syntax
        expect(authorization_class).to contain("belongs_to :group_user")
        expect(authorization_class).to contain("belongs_to :role")
      end
    end

    context "permission class already exists" do
      it "includes validations" do
        provide_existing_class("permission")

        run_generator
        authorization_class = file("app/models/permission.rb")

        expect(authorization_class).to exist
        expect(authorization_class).to have_correct_syntax
        expect(authorization_class).to contain("belongs_to :group_user")
        expect(authorization_class).to contain("belongs_to :role")
      end
    end
  end

  describe "permission migration" do
    context "permissions table does not exist" do
      it "creates a migration to create the permission table" do
        allow(ActiveRecord::Base.connection).to receive(:table_exists?).and_return(false)

        run_generator
        migration = migration_file("db/migrate/create_permissions.rb")
        
        expect(migration).to exist
        expect(migration).to have_correct_syntax
        expect(migration).to contain("create_table :permissions")
      end
    end
  end
end