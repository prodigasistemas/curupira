class RoleGroupUser < ActiveRecord::Base
  belongs_to :role
  belongs_to :group_user
end