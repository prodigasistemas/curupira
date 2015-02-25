require 'rails/generators/active_record'

module Curupira
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
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

      def create_user_model
        copy_file 'models/user.rb', 'app/models/user.rb' unless model_exists?
      end

      def inject_curupira_content
        content = model_content.split("\n").map { |line| "  "  + line.strip! } .join("\n") << "\n"
        inject_into_class("app/models/user.rb", User, content) if model_exists?
      end

      private

      def model_content
        <<-CONTENT
          authenticates_with_sorcery!
          validates_presence_of :email
        CONTENT
      end

      def model_exists?(model_path = "app/models/user.rb")
        File.exists?(File.join(destination_root, model_path))
      end

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
