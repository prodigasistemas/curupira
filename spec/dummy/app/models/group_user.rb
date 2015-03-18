class GroupUser < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :role_group_users
  accepts_nested_attributes_for :role_group_users, reject_if: :all_blank, allow_destroy: :true
  scope :active, -> { where active: true }
end