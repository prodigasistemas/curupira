module ActionDispatch::Routing
  class Mapper
    def curupira_routes
      scope module: 'curupira' do
        resources :users, except: :destroy
      end
    end
  end
end
