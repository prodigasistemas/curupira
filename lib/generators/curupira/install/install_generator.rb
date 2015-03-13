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

      def create_role_group_user
        create_model "role_group_user"
        create_migration_to("role_group_user")
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

      def create_group_user
        create_model "group_user"
        create_migration_to("group_user")
      end

      def create_role_group
        create_model "role_group"
        create_migration_to("role_group")
      end

      def create_service
        create_model "service"
        create_migration_to("service")
      end

      def create_action_label
        create_model "action_label"
        create_migration_to("action_label")
      end

      def create_feature_service
        create_model "feature_service"
        create_migration_to("feature_service")
      end

      def create_feature_action_label
        create_model "feature_action_label"
        create_migration_to("feature_action_label")
      end      

      private

      def self.next_migration_number(dir)
        ActiveRecord::Generators::Base.next_migration_number(dir)
      end

    end
  end
end
