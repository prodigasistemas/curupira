module Curupira
  module Authorizer
    def authorize?(user, controller, action)
      result = User.joins(
                groups: [roles: [:features]]
              )
              .where(
                features: { controller: controller, action: action  },
                id: user
              )

      result.present?
    end
  end
end