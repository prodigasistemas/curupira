class Role < ActiveRecord::Base
  has_many :authorizations
  has_many :features, through: :authorizations
  accepts_nested_attributes_for :authorizations, reject_if: :all_blank, allow_destroy: :true
  
  validates_presence_of :name
end