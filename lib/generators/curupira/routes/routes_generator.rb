module Curupira
  module Generators
    class RoutesGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)

      def inject_routes_into_application_routes
        route(curupira_routes)
      end

      private

      def curupira_routes
        File.read(routes_file_path)
      end

      def routes_file_path
        File.expand_path(find_in_source_paths('routes.rb'))
      end
    end
  end
end
