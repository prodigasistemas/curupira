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
          last_login_from_ip_address: 't.string :last_login_from_ip_address, default: nil',
          admin: 't.boolean :admin, default: false'
        }.reject { |column| existing_columns_to("user").include?(column.to_s) }
      end

      def role_columns
        @role_columns ||= {}
      end

      def role_indexes
        @role_indexes ||= {}
      end

      def group_columns
        @group_columns ||= {}
      end

      def group_indexes
        @group_indexes ||= {}
      end

      def feature_columns
        @feature_columns ||= {}
      end

      def feature_indexes
        @feature_indexes ||= {}
      end

      def authorization_columns
        @authorization_columns ||= {}
      end

      def authorization_indexes
        @authorization_indexes ||= {}
      end

      def role_group_user_columns
        @role_group_user_columns ||= {}
      end

      def role_group_user_indexes
        @role_group_user_indexes ||= {}
      end

      def role_group_columns
        @role_group_columns ||= {}
      end

      def role_group_indexes
        @role_group_indexes ||= {}
      end

      def user_indexes
        @user_indexes ||= {
          index_users_on_username: 'add_index :users, :username, unique: true',
          index_users_on_reset_password_token: 'add_index :users, :reset_password_token',
          index_users_on_last_logout_at: 'add_index :users, :last_logout_at',
          index_users_on_last_activity_at: 'add_index :users, :last_activity_at'
        }.reject { |index| existing_indexes_to("user").include?(index.to_s) }
      end

      def group_user_columns
        @group_user_columns ||= {}
      end

      def group_user_indexes
        @group_user_indexes ||= {}
      end

      def action_label_columns
        @action_label_columns ||= {}
      end

      def action_label_indexes
        @action_label_indexes ||= {}
      end

      def create_model(model_name)
        copy_file "models/#{model_name}.rb", "app/models/#{model_name}.rb" unless model_exists?("app/models/#{model_name}.rb")
        content = self.send("#{model_name}_model_content").split("\n").map { |line| "  " + line.strip! } .join("\n") << "\n"
        inject_into_class("app/models/#{model_name}.rb", model_name.camelize, content)
      end

      def role_group_user_model_content
        <<-CONTENT
          belongs_to :group_user
          belongs_to :role
        CONTENT
      end

      def authorization_model_content
        <<-CONTENT
          belongs_to :feature
          belongs_to :role
        CONTENT
      end

      def user_model_content
        <<-CONTENT
          authenticates_with_sorcery!
          validates_presence_of :email
          has_many :group_users
          has_many :groups, through: :group_users
          has_many :role_group_users, through: :group_users
          accepts_nested_attributes_for :group_users, reject_if: :all_blank, allow_destroy: :true
          accepts_nested_attributes_for :role_group_users, reject_if: :all_blank, allow_destroy: :true
          
          scope :all_belonging_to, -> (user) { includes(group_users: :group).where(groups: { id: user.groups }) }
        CONTENT
      end

      def group_model_content
        <<-CONTENT
          has_many :role_groups
          has_many :roles, through: :role_groups
          has_many :group_users
          has_many :users, through: :group_users
          accepts_nested_attributes_for :role_groups, reject_if: :all_blank, allow_destroy: :true
          validates_presence_of :name
          scope :active, -> { where active: true }
        CONTENT
      end

      def role_model_content
        <<-CONTENT
          has_many :authorizations
          has_many :features, through: :authorizations
          has_many :role_group_users
          has_many :group_users, through: :role_group_users
          has_many :role_groups
          has_many :groups, through: :role_groups
          accepts_nested_attributes_for :authorizations, reject_if: :all_blank, allow_destroy: :true
          validates_presence_of :name
        CONTENT
      end

      def feature_model_content
        <<-CONTENT
          has_many :action_labels
        CONTENT
      end

      def group_user_model_content
        <<-CONTENT
          belongs_to :group
          belongs_to :user
          has_many :role_group_users
          accepts_nested_attributes_for :role_group_users, reject_if: :all_blank, allow_destroy: :true
          scope :active, -> { where active: true }
        CONTENT
      end

      def role_group_model_content
        <<-CONTENT
          belongs_to :role
          belongs_to :group
        CONTENT
      end

      def action_label_model_content
        <<-CONTENT
          belongs_to :feature
        CONTENT
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