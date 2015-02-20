require "test_helper"
require "generators/curupira/install/install_generator"

class InstallGeneratorTest < Rails::Generators::TestCase
  tests Curupira::Generators::InstallGenerator
  
  destination File.expand_path("../../tmp", __FILE__)
  setup :prepare_destination
  
  test "model file is created" do
    run_generator
    assert_file "app/models/user.rb"
  end
  
  test "user migration is created" do
    run_generator
    assert_migration "db/migrate/create_users.rb"
  end
end