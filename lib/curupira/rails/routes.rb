module ActionDispatch::Routing
  class Mapper
    def curupira_routes
      scope module: 'curupira' do
        resources :users, except: :destroy
        resources :groups, except: :destroy
        resources :roles, except: :destroy
        resource :session, only: [:new, :create] do
          get :destroy, as: :destroy
        end
        resources :features
        resources :passwords, only: [:new, :create, :edit, :update]
      end
    end
  end
end
