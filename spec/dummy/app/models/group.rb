class Group < ActiveRecord::Base
  validates_presence_of :name
  has_many :group_users
  has_many :role_groups
  has_many :roles, through: :role_groups
  has_many :users, through: :group_users
  accepts_nested_attributes_for :role_groups, reject_if: :all_blank, allow_destroy: :true

  scope :active, -> { where active: true }
end