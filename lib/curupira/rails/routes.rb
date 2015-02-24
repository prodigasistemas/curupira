module ActionDispatch::Routing
  class Mapper
    def curupira_routes
      scope module: 'curupira' do
        resources :users, except: :destroy
        resource :session, only: [:new, :create] do
          get :destroy, as: :destroy
        end
      end
    end
  end
end
