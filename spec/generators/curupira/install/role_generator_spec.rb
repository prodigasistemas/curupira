require 'rails_helper'
require "generators/curupira/install/install_generator"

describe Curupira::Generators::InstallGenerator, :generator do
  
  before do
    provide_existing_routes_file
  end

  describe "role_model" do
    context "no existing role class" do
      it_behaves_like "valid role model"
    end

    context "role class already exists" do
      before do
        provide_existing_class("role")
      end

      it_behaves_like "valid role model"
    end
  end

  describe "role migration" do
    context "roles table does not exist" do
      it "creates a migration to create the roles table" do
        allow(ActiveRecord::Base.connection).to receive(:table_exists?).and_return(false)

        run_generator
        migration = migration_file("db/migrate/create_roles.rb")

        expect(migration).to exist
        expect(migration).to have_correct_syntax
        expect(migration).to contain("create_table :roles")
      end
    end
  end
end