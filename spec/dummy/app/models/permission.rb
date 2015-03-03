class Permission < ActiveRecord::Base
  belongs_to :group_user
  belongs_to :role
end