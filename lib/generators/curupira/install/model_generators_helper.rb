module Curupira
  module Generators
    module ModelGeneratorsHelper
      include Rails::Generators::Migration

      def table_exists?(table_name)
        ActiveRecord::Base.connection.table_exists?(table_name)
      end

      def create_add_columns_migration_to(model_name)
        if migration_needed?(model_name)
          config = {
            columns: columns_by(model_name),
            indexes: indexes_by(model_name)
          }
          
          copy_migration("add_curupira_to_#{model_name.pluralize}.rb", config)
        end
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

      def create_migration_to(model_name)
        if table_exists?(model_name)
          create_add_columns_migration_to(model_name)    
        else
          copy_migration "create_#{model_name.pluralize}.rb"
        end
      end

      def migration_exists?(name)
        existing_migrations.include?(name)
      end

      def existing_migrations
        @existing_migrations ||= Dir.glob("db/migrate/*.rb").map do |file|
          migration_name_without_timestamp(file)
        end
      end

      def migration_name_without_timestamp(file)
        file.sub(%r{^.*(db/migrate/)(?:\d+_)?}, '')
      end

      def migration_needed?(model_name)
        columns_by(model_name).any? || indexes_by(model_name).any?
      end

      def user_columns
        @user_columns ||= {
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
        }.reject { |column| existing_columns_to("user").include?(column.to_s) }
      end

      def user_indexes
        @user_indexes ||= {
          index_users_on_username: 'add_index :users, :username, unique: true',
          index_users_on_reset_password_token: 'add_index :users, :reset_password_token',
          index_users_on_last_logout_at: 'add_index :users, :last_logout_at',
          index_users_on_last_activity_at: 'add_index :users, :last_activity_at'
        }.reject { |index| existing_indexes_to("user").include?(index.to_s) }
      end

      def columns_by(model_name)
        self.send("#{model_name}_columns")
      end

      def indexes_by(model_name)
        self.send("#{model_name}_indexes")
      end

      def model_exists?(model_path)
        File.exists?(File.join(destination_root, model_path))
      end

      def table_exists?(model_name)
        ActiveRecord::Base.connection.table_exists?(model_name.pluralize.to_sym)
      end

      def existing_columns_to(model_name)
        ActiveRecord::Base.connection.columns(model_name.pluralize.to_sym).map(&:name)
      end

      def existing_indexes_to(model_name)
        ActiveRecord::Base.connection.indexes(model_name.pluralize.to_sym).map(&:name)
      end

    end
  end
end