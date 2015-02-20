require 'rails/generators/active_record'

module Curupira
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)

      def create_user_model
        if File.exist? "app/models/user.rb"
          inject_into_file(
            "app/models/user.rb",
            "has_and_belongs_to_many :roles\n\n",
            after: "class User < ActiveRecord::Base\n"
          )
        else
          copy_file 'user.rb', 'app/models/user.rb'
        end
      end

      def create_role_model
        if File.exist? "app/models/role.rb"
          inject_into_file(
            "app/models/role.rb",
            "has_and_belongs_to_many :users\n\n",
            after: "class Role < ActiveRecord::Base\n"
          )
        else
          copy_file 'role.rb', 'app/models/role.rb'
        end
      end

      def create_feature_model
        if File.exist? "app/models/feature.rb"
          inject_into_file(
            "app/models/feature.rb",
            "has_and_belongs_to_many :roles\n\n",
            after: "class Feature < ActiveRecord::Base\n"
          )
        else
          copy_file 'feature.rb', 'app/models/feature.rb'
        end
      end

      def create_user_migration
        # if users_table_exists?
        #   create_add_columns_migration
        # else
        #   copy_migration 'create_users.rb'
        # end
        copy_migration 'create_users.rb'
      end

      def create_role_migration
        copy_migration 'create_roles.rb'
      end

      def create_roles_users_migration
        copy_migration 'create_roles_users.rb'
      end

      def create_features_migration
        copy_migration 'create_features.rb'
      end

      def create_roles_features_migration
        copy_migration 'create_roles_features.rb'
      end

      private

      def users_table_exists?
        ActiveRecord::Base.connection.table_exists?(:users)
      end

      def copy_migration(migration_name, config = {})
        # unless migration_exists?(migration_name)
        #   migration_template(
        #     "db/migrate/#{migration_name}",
        #     "db/migrate/#{migration_name}",
        #     config
        #   )
        # end
        migration_template(
          "db/migrate/#{migration_name}",
          "db/migrate/#{migration_name}"
        )
      end

      def self.next_migration_number(dir)
        ActiveRecord::Generators::Base.next_migration_number(dir)
      end
    end
  end
end