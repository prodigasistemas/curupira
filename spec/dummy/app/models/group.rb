class Group < ActiveRecord::Base
  validates_presence_of :name
  has_many :group_roles
  has_many :roles, through: :group_roles
  scope :active, -> { where active: true }
end