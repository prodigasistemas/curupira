class User < ActiveRecord::Base
  authenticates_with_sorcery!
  validates_presence_of :email
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :permissions, through: :group_users
  accepts_nested_attributes_for :group_users, reject_if: :all_blank, allow_destroy: :true
  authenticates_with_sorcery!
  validates_presence_of :email

  has_many :group_users
  has_many :groups, through: :group_users
  has_many :permissions, through: :group_users

  accepts_nested_attributes_for :group_users, reject_if: :all_blank, allow_destroy: :true
end
