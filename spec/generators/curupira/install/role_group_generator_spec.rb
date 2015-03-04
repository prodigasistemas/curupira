require 'rails_helper'
require 'generators/curupira/install/install_generator'

describe Curupira::Generators::InstallGenerator, :generator do
  before do
    provide_existing_routes_file
  end

  describe "role_group_model" do
    context "no existing role group class" do
      it "generates role group" do
        run_generator
        role_group_class = file("app/models/role_group.rb")

        expect(role_group_class).to exist
        expect(role_group_class).to have_correct_syntax
        expect(role_group_class).to contain("belongs_to :role")
        expect(role_group_class).to contain("belongs_to :group")
      end
    end

    context "role group class already exists" do
      it "includes validations" do
        provide_existing_class("role_group")

        run_generator
        role_group_class = file("app/models/role_group.rb")

        expect(role_group_class).to exist
        expect(role_group_class).to have_correct_syntax
        expect(role_group_class).to contain("belongs_to :group")
        expect(role_group_class).to contain("belongs_to :user")
      end
    end
  end

  describe "role group migration" do
    context "role_group table does not exist" do
      it "creates a migration to create the role_groups table" do
        allow(ActiveRecord::Base.connection).to receive(:table_exists?).and_return(false)

        run_generator
        migration = migration_file("db/migrate/create_role_groups.rb")

        expect(migration).to exist
        expect(migration).to have_correct_syntax
        expect(migration).to contain("create_table :role_groups")
      end
    end
  end
end