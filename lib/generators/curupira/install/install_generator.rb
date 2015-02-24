require 'rails/generators/active_record'

module Curupira
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../../templates', __FILE__)

      def create_routes
        invoke "curupira:routes"
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

      def create_user_model
        # if File.exist? "app/models/user.rb"
        #   inject_into_file(
        #     "app/models/user.rb",
        #     "has_and_belongs_to_many :roles\n\n",
        #     after: "class User < ActiveRecord::Base\n"
        #   )
        # else
        #   copy_file 'user.rb', 'app/models/user.rb'
        # end
      end

      private

      def copy_migration(migration_name, config = {})
        # unless migration_exists?(migration_name)
        #   migration_template(
        #     "db/migrate/#{migration_name}",
        #     "db/migrate/#{migration_name}",
        #     config
        #   )
        # end
        # migration_template(
        #   "db/migrate/#{migration_name}",
        #   "db/migrate/#{migration_name}"
        # )
      end

      def self.next_migration_number(dir)
        ActiveRecord::Generators::Base.next_migration_number(dir)
      end
    end
  end
end
