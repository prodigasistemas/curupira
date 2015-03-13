class FeatureActionLabel < ActiveRecord::Base
  belongs_to :feature
  belongs_to :action_label
end
