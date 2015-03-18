require "rails_helper"
require "generators/curupira/install/install_generator"

describe Curupira::Generators::InstallGenerator, :generator do
  before do
    provide_existing_routes_file
  end

  describe "action_label" do
    context "no existing action_label class" do
      it "generates action_label" do
        run_generator
        feature_class = file("app/models/action_label.rb")

        expect(feature_class).to exist
        expect(feature_class).to have_correct_syntax
        expect(feature_class).to contain("belongs_to :feature")
      end
    end

    context "action_label class already exists" do
      it "includes validations" do
        provide_existing_class("action_label")

        run_generator
        feature_class = file("app/models/action_label.rb")

        expect(feature_class).to exist
        expect(feature_class).to have_correct_syntax
        expect(feature_class).to contain("belongs_to :feature")
      end
    end
  end

  describe "action_label migration" do
    context "action_labels table does not exist" do
      it "creates a migration to create the action_labels table" do
        allow(ActiveRecord::Base.connection).to receive(:table_exists?).and_return(false)

        run_generator
        migration = migration_file("db/migrate/create_action_labels.rb")

        expect(migration).to exist
        expect(migration).to have_correct_syntax
        expect(migration).to contain("create_table :action_labels")
        expect(migration).to contain("t.string :name")
        expect(migration).to contain("t.belongs_to :feature, index: true")
        expect(migration).to contain("t.boolean :active, default: true")
        expect(migration).to contain("add_foreign_key :action_labels, :features")
      end
    end
  end
end