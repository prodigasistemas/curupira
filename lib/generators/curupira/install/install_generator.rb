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

      def create_user_migration
        if users_table_exists?
          create_add_columns_migration
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

      def model_exists?(model_path = "app/models/user.rb")
        File.exists?(File.join(destination_root, model_path))
      end

      def users_table_exists?
        ActiveRecord::Base.connection.table_exists?(:users)
      end

      def create_add_columns_migration
        if migration_needed?
          config = {
            new_columns: new_columns,
            new_indexes: new_indexes
          }
          
          copy_migration('add_curupira_to_users.rb', config)
        end
      end

      def new_columns
        @new_columns ||= {
          email: 't.string :email, null: false',
          name: 't.string :name, null: false',
          active: 't.boolean :active, null: false',
          username: 't.string',
          crypted_password: 't.string :crypted_password',
          salt: 't.string :salt, default: nil',
          reset_password_token: 't.string :reset_password_token, default: nil',
          reset_password_token_expires_at: 't.datetime :reset_password_token_expires_at, default: nil',
          reset_password_email_sent_at: 't.datetime :reset_password_email_sent_at, default: nil',
          last_login_at: 't.datetime :last_login_at, default: nil',
          last_logout_at: 't.datetime :last_logout_at, default: nil',
          last_activity_at: 't.datetime :last_activity_at, default: nil',
          last_login_from_ip_address: 't.string :last_login_from_ip_address, default: nil'
        }.reject { |column| existing_users_columns.include?(column.to_s) }
      end

      def new_indexes
        @new_indexes ||= {
          index_users_on_username: 'add_index :users, :username, unique: true',
          index_users_on_reset_password_token: 'add_index :users, :reset_password_token',
          index_users_on_last_logout_at: 'add_index :users, :last_logout_at',
          index_users_on_last_activity_at: 'add_index :users, :last_activity_at'
        }.reject { |index| existing_users_indexes.include?(index.to_s) }
      end

      def migration_needed?
        new_columns.any? || new_indexes.any?
      end

      def migration_exists?(name)
        existing_migrations.include?(name)
      end

      def existing_migrations
        @existing_migrations ||= Dir.glob("db/migrate/*.rb").map do |file|
          migration_name_without_timestamp(file)
        end
      end

      def existing_users_columns
        ActiveRecord::Base.connection.columns(:users).map(&:name)
      end

      def existing_users_indexes
        ActiveRecord::Base.connection.indexes(:users).map(&:name)
      end

      def copy_migration(migration_name, config = {})
        unless migration_exists?(migration_name)
          migration_template(
            "db/migrate/#{migration_name}",
            "db/migrate/#{migration_name}",
            config
          )
        end
      end

      def self.next_migration_number(dir)
        ActiveRecord::Generators::Base.next_migration_number(dir)
      end

      def migration_name_without_timestamp(file)
        file.sub(%r{^.*(db/migrate/)(?:\d+_)?}, '')
      end
    end
  end
end
