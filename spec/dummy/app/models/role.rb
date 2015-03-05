class Role < ActiveRecord::Base
  has_many :authorizations
  has_many :features, through: :authorizations
  has_many :role_groups
  has_many :role_groups, through: :role_groups
  accepts_nested_attributes_for :authorizations, reject_if: :all_blank, allow_destroy: :true
  
  validates_presence_of :name
end