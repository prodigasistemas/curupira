module Curupira
  module Authorizer
    extend ActiveSupport::Concern

    def authorize
      unless has_authorization?
        deny_access
      end
    end

    def has_authorization?
      query(params).present?
    end

    def has_authorization_for(params)
      query(params).present?
    end

    private

    def deny_access
      redirect_to "/", notice: "Sem autorização"
    end

    def query(params)
      User.joins(
        permissions: { role: :features } 
      )
      .where(
        features: { controller: params[:controller], action: params[:action]  },
        id: current_user
      )
    end
  end
end