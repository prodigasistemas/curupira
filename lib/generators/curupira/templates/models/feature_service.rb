class FeatureService < ActiveRecord::Base
  belongs_to :feature
  belongs_to :service
end