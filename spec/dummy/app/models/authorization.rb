class Authorization < ActiveRecord::Base
  belongs_to :feature
  belongs_to :role
end