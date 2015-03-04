module Curupira
  module Authorizer
    extend ActiveSupport::Concern

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
                groups: [roles: [:features]]
              )
              .where(
                features: { controller: params[:controller], action: params[:action]  },
                id: current_user
              )

      result.present?
    end
  end
end