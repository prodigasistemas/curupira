require 'rails_helper'
require "generators/curupira/install/install_generator"

describe Curupira::Generators::InstallGenerator, :generator do

  before :all do
    Object.send(:remove_const, :UserGroup) if defined?(UserGroup)
  end

  before do
    provide_existing_routes_file
  end

  describe "sorccery initializer" do
    it "is copied to the application" do
      run_generator
      initializer = file("config/initializers/sorcery.rb")

      expect(initializer).to exist
      expect(initializer).to have_correct_syntax
      expect(initializer).to contain("Rails.application.config.sorcery.configure do |config|")
    end
  end

  describe "user_group" do
    context "no existing user group class" do
      it "generates user group" do
        run_generator

        user_group = file("app/models/user_group.rb")

        expect(user_group).to exist
      end
    end

    it "adds validations" do
      run_generator

      user_group = file("app/models/user_group.rb")

      expect(user_group).to contain("validates_presence_of :name")
    end
  end

  describe "user_model" do
    context "no existing user class" do
      it "creates a user class including Clearance::User" do
        # provide_existing_application_controller

        run_generator
        user_class = file("app/models/user.rb")

        expect(user_class).to exist
        expect(user_class).to have_correct_syntax
        expect(user_class).to contain("authenticates_with_sorcery!")
        expect(user_class).to contain("validates_presence_of :email")
      end
    end

    context "user class already exists" do
      it "includes Clearance::User" do
        provide_existing_user_class

        run_generator
        user_class = file("app/models/user.rb")

        expect(user_class).to exist
        expect(user_class).to have_correct_syntax
        expect(user_class).to contain("authenticates_with_sorcery!")
        expect(user_class).to contain("validates_presence_of :email")
      end
    end
  end
end
