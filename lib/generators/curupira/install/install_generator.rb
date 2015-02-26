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

      def create_groups_model
        create_model "group"
      end

      def create_role_model
        create_model "role"
      end

      def create_user_model
        create_model "user"
      end

      def create_role_migration
        create_migration_to("role")
      end

      def create_groups_migration
        create_migration_to("group")
      end

      def create_user_migration
        if table_exists?("user")
          create_add_columns_migration_to("user")    
        else
          copy_migration 'sorcery_core.rb'
        end
      end

      private

      def create_model(model_name)
        copy_file "models/#{model_name}.rb", "app/models/#{model_name}.rb" unless model_exists?("app/models/#{model_name}.rb")
        content = self.send("#{model_name}_model_content").split("\n").map { |line| "  "  + line.strip! } .join("\n") << "\n"
        inject_into_class("app/models/#{model_name}.rb", model_name.camelize, content)
      end

      def user_model_content
        <<-CONTENT
          authenticates_with_sorcery!
          validates_presence_of :email
        CONTENT
      end

      def group_model_content
        <<-CONTENT
          validates_presence_of :name
          scope :active, -> { where active: true }
        CONTENT
      end

      def role_model_content
        <<-CONTENT
          validates_presence_of :name
        CONTENT
      end

      def self.next_migration_number(dir)
        ActiveRecord::Generators::Base.next_migration_number(dir)
      end

    end
  end
end
