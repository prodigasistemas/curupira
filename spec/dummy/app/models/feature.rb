class Feature < ActiveRecord::Base
	has_many :feature_services
	has_many :services, through: :feature_services
  has_many :action_labels
end
