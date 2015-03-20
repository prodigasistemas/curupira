module ActionDispatch::Routing
  class Mapper
    def curupira_routes
      scope module: 'curupira' do
        resources :users, except: :destroy do
          get 'groups/:group_id/roles', action: :permission, controller: :users
        end

        resources :groups, except: :destroy
        resources :roles, except: :destroy
        resource :session, only: [:new, :create] do
          get :destroy, as: :destroy
        end
        resources :passwords, only: [:new, :create, :edit, :update]
      end
    end
  end
end
