module Curupira
  module Authorizer
    extend ActiveSupport::Concern

    def authorize_for_group
      unless has_authorization_for_group?
        deny_access
      end
    end

    def authorize
      unless has_authorization?
        deny_access
      end
    end

    def deny_access
      redirect_to "/", notice: "Sem autorização"
    end

    def has_authorization?
      result = User.joins(
                permissions: { role: :features } 
              )
              .where(
                features: { controller: params[:controller], action: params[:action]  },
                id: current_user
              )

      result.present?
    end
  end
end