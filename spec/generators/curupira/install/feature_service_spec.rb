require "rails_helper"
require 'generators/curupira/install/install_generator'

describe Curupira::Generators::InstallGenerator, :generator do
  before do
    provide_existing_routes_file
  end

  describe "feature_service" do
    context "no existing feature service class" do
      it "generates feature service" do
        run_generator
        role_group_class = file("app/models/feature_service.rb")

        expect(role_group_class).to exist
        expect(role_group_class).to have_correct_syntax
        expect(role_group_class).to contain("belongs_to :feature")
        expect(role_group_class).to contain("belongs_to :service")
      end
    end

    context "feature service class already exists" do
      it "includes validations" do
        provide_existing_class("feature_service")

        run_generator
        role_group_class = file("app/models/feature_service.rb")

        expect(role_group_class).to exist
        expect(role_group_class).to have_correct_syntax
        expect(role_group_class).to contain("belongs_to :feature")
        expect(role_group_class).to contain("belongs_to :service")
      end
    end
  end

  describe "feature service migration" do
    context "feature_services table does not exist" do
      it "creates a migration to create the feature_services table" do
        allow(ActiveRecord::Base.connection).to receive(:table_exists?).and_return(false)

        run_generator
        migration = migration_file("db/migrate/create_feature_services.rb")

        expect(migration).to exist
        expect(migration).to have_correct_syntax
        expect(migration).to contain("create_table :feature_services")
        expect(migration).to contain("t.belongs_to :feature")
        expect(migration).to contain("t.belongs_to :service")
      end
    end
  end
end