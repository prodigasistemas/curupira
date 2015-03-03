require 'rails_helper'
require 'generators/curupira/install/install_generator'

describe Curupira::Generators::InstallGenerator, :generator do
  before do
    provide_existing_routes_file
  end

  describe "group_user_model" do
    context "no existing group user class" do
      it "generates group user" do
        run_generator
        group_user_class = file("app/models/group_user.rb")

        expect(group_user_class).to exist
        expect(group_user_class).to have_correct_syntax
        expect(group_user_class).to contain("belongs_to :group")
        expect(group_user_class).to contain("belongs_to :user")
      end
    end

    context "group user class already exists" do
      it "includes validations" do
        provide_existing_class("group_user")

        run_generator
        group_user_class = file("app/models/group_user.rb")

        expect(group_user_class).to exist
        expect(group_user_class).to have_correct_syntax
        expect(group_user_class).to contain("belongs_to :group")
        expect(group_user_class).to contain("belongs_to :user")
      end
    end
  end

  describe "group user migration" do
    context "group_users table does not exist" do
      it "creates a migration to create the group_users table" do
        allow(ActiveRecord::Base.connection).to receive(:table_exists?).and_return(false)

        run_generator
        migration = migration_file("db/migrate/create_group_users.rb")

        expect(migration).to exist
        expect(migration).to have_correct_syntax
        expect(migration).to contain("create_table :group_users")
      end
    end
  end
end