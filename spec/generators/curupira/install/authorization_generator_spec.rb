require 'rails_helper'
require "generators/curupira/install/install_generator"

describe Curupira::Generators::InstallGenerator, :generator do
  before do
    provide_existing_routes_file
  end

  describe "authorization_model" do
    context "no existing authorization class" do
      it "generates authorization" do
        run_generator
        authorization_class = file("app/models/authorization.rb")

        expect(authorization_class).to exist
        expect(authorization_class).to have_correct_syntax
        expect(authorization_class).to contain("belongs_to :feature")
        expect(authorization_class).to contain("belongs_to :role")
      end
    end

    context "authorization class already exists" do
      it "includes validations" do
        provide_existing_class("authorization")

        run_generator
        authorization_class = file("app/models/authorization.rb")

        expect(authorization_class).to exist
        expect(authorization_class).to have_correct_syntax
        expect(authorization_class).to contain("belongs_to :feature")
        expect(authorization_class).to contain("belongs_to :role")
      end
    end
  end

  describe "authorization migration" do
    context "authorizations table does not exist" do
      it "creates a migration to create the authorization table" do
        allow(ActiveRecord::Base.connection).to receive(:table_exists?).and_return(false)

        run_generator
        migration = migration_file("db/migrate/create_authorizations.rb")

        expect(migration).to exist
        expect(migration).to have_correct_syntax
        expect(migration).to contain("create_table :authorizations")
      end
    end
  end
end