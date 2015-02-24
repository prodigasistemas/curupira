require "test_helper"
require "generators/curupira/install/install_generator"

class InstallGeneratorTest < Rails::Generators::TestCase
  tests Curupira::Generators::InstallGenerator

  destination File.expand_path("../../../tmp", __FILE__)

  setup do
    prepare_destination
    copy_routes
  end

  test "route generation for simple model names" do
    run_generator
    assert_file "config/routes.rb", /curupira_routes/
  end

  def copy_routes
    routes = File.expand_path("../../../dummy/config/routes.rb", __FILE__)
    destination = File.join(destination_root, "config")

    FileUtils.mkdir_p(destination)
    FileUtils.cp routes, destination
  end
end
