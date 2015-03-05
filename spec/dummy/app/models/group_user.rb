class GroupUser < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :permissions
  accepts_nested_attributes_for :permissions, reject_if: :all_blank, allow_destroy: :true
  scope :active, -> { where active: true }
end