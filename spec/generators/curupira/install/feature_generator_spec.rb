require 'rails_helper'
require "generators/curupira/install/install_generator"

describe Curupira::Generators::InstallGenerator, :generator do
  before do
    provide_existing_routes_file
  end

  describe "feature_model" do
    context "no existing feature class" do
      it "generates feature" do
        run_generator
        feature_class = file("app/models/feature.rb")

        expect(feature_class).to exist
        expect(feature_class).to have_correct_syntax
        expect(feature_class).to contain("validates_presence_of :name")
      end
    end

    context "feature class already exists" do
      it "includes validations" do
        provide_existing_class("feature")

        run_generator
        feature_class = file("app/models/feature.rb")

        expect(feature_class).to exist
        expect(feature_class).to have_correct_syntax
        expect(feature_class).to contain("validates_presence_of :name")
      end
    end
  end

  describe "feature migration" do
    context "features table does not exist" do
      it "creates a migration to create the features table" do
        allow(ActiveRecord::Base.connection).to receive(:table_exists?).and_return(false)

        run_generator
        migration = migration_file("db/migrate/create_features.rb")

        expect(migration).to exist
        expect(migration).to have_correct_syntax
        expect(migration).to contain("create_table :features")
      end
    end
  end
end