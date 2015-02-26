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

      def create_user_groups
        invoke("active_record:model", ["user_group", "name:string", "active:boolean"]) unless model_exists?("app/models/user_groups.rb")
        inject_into_class("app/models/user_group.rb", "UserGroup", "  validates_presence_of :name\n")
      end

      def copy_initializer
        copy_file 'sorcery.rb', 'config/initializers/sorcery.rb'
      end

      def create_controlers # TEST ME
        # invoke "curupira:controllers"
      end

      def create_views # TEST ME
        # invoke "curupira:views"
      end

      def create_role_model
        copy_file 'models/role.rb', 'app/models/role.rb' unless model_exists?("app/models/role.rb")
        inject_into_class("app/models/role.rb", "Role", "  validates_presence_of :name\n")
      end

      def create_user_model
        copy_file 'models/user.rb', 'app/models/user.rb' unless model_exists?("app/models/user.rb")
      end

      def inject_curupira_content
        content = model_content.split("\n").map { |line| "  "  + line.strip! } .join("\n") << "\n"
        inject_into_class("app/models/user.rb", User, content) if model_exists?("app/models/user.rb")
      end

      def create_role_migration
        create_migration_to("role")
      end

      def create_user_migration
        if table_exists?("user")
          create_add_columns_migration_to("user")    
        else
          copy_migration 'sorcery_core.rb'
        end
      end

      private

      def model_content
        <<-CONTENT
          authenticates_with_sorcery!
          validates_presence_of :email
        CONTENT
      end

      def self.next_migration_number(dir)
        ActiveRecord::Generators::Base.next_migration_number(dir)
      end

    end
  end
end
