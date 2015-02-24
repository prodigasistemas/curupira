require 'rails_helper'
require "generators/curupira/install/install_generator"

describe Curupira::Generators::InstallGenerator, :generator do
  describe "sorccery initializer" do
    it "is copied to the application" do
      # provide_existing_application_controller
      provide_existing_routes_file
      
      run_generator
      initializer = file("config/initializers/sorcery.rb")

      expect(initializer).to exist
      expect(initializer).to have_correct_syntax
      expect(initializer).to contain("Rails.application.config.sorcery.configure do |config|")
    end
  end
end