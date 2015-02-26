class UserGroup < ActiveRecord::Base
  validates_presence_of :name

  scope :active, -> { where active: true }
end
