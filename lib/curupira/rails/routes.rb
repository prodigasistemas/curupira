module ActionDispatch::Routing
  class Mapper
    def curupira_routes
      scope module: 'curupira' do
        resources :users, except: :destroy
        resource :session, only: [:new, :create] do
          get :destroy, as: :destroy
        end
        #verificar quais acoes usaremos no controller Action
        resources :features
      end
    end
  end
end