module Curupira
  module Generators
    class ControllersGenerator < Rails::Generators::Base
      source_root File.expand_path("../" * 4, __FILE__)

      def create_role_controller
        controllers.each do |controller|
          copy_file controller
        end
      end

      def controllers
        files_within_root('.', 'app/controllers/*')
      end

      private

      def files_within_root(prefix, glob)
        root = "#{self.class.source_root}/#{prefix}"

        Dir["#{root}/#{glob}"].sort.map do |full_path|
          full_path.sub(root, '.').gsub('/./', '/')
        end
      end
    end
  end
end