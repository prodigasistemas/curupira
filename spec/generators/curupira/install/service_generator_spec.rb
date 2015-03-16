require "rails_helper"
require "generators/curupira/install/install_generator"

describe Curupira::Generators::InstallGenerator, :generator do
  before do
    provide_existing_routes_file
  end

  describe "service_model" do
    context "no existing service class" do
      it "generates service" do
        run_generator
        feature_class = file("app/models/service.rb")

        expect(feature_class).to exist
        expect(feature_class).to have_correct_syntax
        expect(feature_class).to contain("has_many :feature_services")
        expect(feature_class).to contain("has_many :services, through: :feature_services")
      end
    end

    context "service class already exists" do
      it "includes validations" do
        provide_existing_class("service")

        run_generator
        feature_class = file("app/models/service.rb")

        expect(feature_class).to exist
        expect(feature_class).to have_correct_syntax
        expect(feature_class).to contain("has_many :feature_services")
        expect(feature_class).to contain("has_many :services, through: :feature_services")
      end
    end
  end

  describe "service migrate" do
    context "services table does not exist" do
      it "creates a migration to create the services table" do
        allow(ActiveRecord::Base.connection).to receive(:table_exists?).and_return(false)

        run_generator
        migration = migration_file("db/migrate/create_services.rb")

        expect(migration).to exist
        expect(migration).to have_correct_syntax
        expect(migration).to contain("create_table :services")
        expect(migration).to contain("t.string :name")
        expect(migration).to contain("t.boolean :active, default: true")
      end
    end
  end
end