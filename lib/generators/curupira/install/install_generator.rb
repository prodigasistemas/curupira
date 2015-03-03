require 'rails/generators/active_record'
require 'generators/curupira/install/model_generators_helper'

module Curupira
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      include Curupira::Generators::ModelGeneratorsHelper

      source_root File.expand_path('../../templates', __FILE__)

      def create_routes
        invoke "curupira:routes"
      end

      def copy_initializer
        copy_file 'sorcery.rb', 'config/initializers/sorcery.rb'
      end

      def create_permission
        create_model "permission"
        create_migration_to("permission")
      end

      def create_authorization
        create_model "authorization"
        create_migration_to("authorization")
      end

      def create_feature
        create_model "feature"
        create_migration_to("feature")
      end

      def create_groups
        create_model "group"
        create_migration_to("group")
      end

      def create_role
        create_model "role"
        create_migration_to("role")
      end

      def create_user_model
        create_model "user"
      end

      def create_user_migration
        if table_exists?("user")
          create_add_columns_migration_to("user")    
        else
          copy_migration 'sorcery_core.rb'
        end
      end

      private

      def self.next_migration_number(dir)
        ActiveRecord::Generators::Base.next_migration_number(dir)
      end

    end
  end
end
