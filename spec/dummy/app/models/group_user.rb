class GroupUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  has_many :permissions

  accepts_nested_attributes_for :permissions, reject_if: :all_blank, allow_destroy: :true
end
