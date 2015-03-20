class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates_presence_of :email
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :role_group_users, through: :group_users
  accepts_nested_attributes_for :group_users, reject_if: :all_blank, allow_destroy: :true
  accepts_nested_attributes_for :role_group_users, reject_if: :all_blank, allow_destroy: :true
  
  scope :all_belonging_to, -> (user) { includes(group_users: :group).where(groups: { id: user.groups }) }
end