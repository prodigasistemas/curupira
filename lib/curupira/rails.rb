require 'curupira/rails/routes'

module Curupira
  class Engine < Rails::Engine
    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

    initializer "curupira.load_app_instance_data" do |app|
      Curupira.setup do |config|
        config.app_root = app.root
      end
    end

    initializer "curupira.load_static_assets" do |app|
      app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end

    initializer 'curupira.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper Curupira::RelationshipSelectOptionsHelper
        include Curupira::Authorizer
        helper_method :has_authorization_for
      end
    end
  end
end
