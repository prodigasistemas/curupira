require "test_helper"
require "generators/curupira/install/install_generator"

class InstallGeneratorTest < Rails::Generators::TestCase
  tests Curupira::Generators::InstallGenerator

  destination File.expand_path("../../../tmp", __FILE__)

  setup do
    prepare_destination
    copy_routes
  end

  test "model user is created" do
    run_generator
    assert_file "app/models/user.rb"
  end

  test "user migration is created" do
    run_generator
    assert_migration "db/migrate/create_users.rb"
  end

  test "model role is created" do
    run_generator
    assert_file "app/models/role.rb"
  end

  test "role migration is created" do
    run_generator
    assert_migration "db/migrate/create_roles.rb"
  end

  test "roles_users migration is created" do
    run_generator
    assert_migration "db/migrate/create_roles_users.rb"
  end

  test "model feature is created" do
    run_generator
    assert_file "app/models/feature.rb"
  end

  test "feature migration is created" do
    run_generator
    assert_migration "db/migrate/create_features.rb"
  end

  test "roles_features migration is created" do
    run_generator
    assert_migration "db/migrate/create_roles_features.rb"
  end

  def copy_routes
    routes = File.expand_path("../../../dummy/config/routes.rb", __FILE__)
    destination = File.join(destination_root, "config")

    FileUtils.mkdir_p(destination)
    FileUtils.cp routes, destination
  end
end