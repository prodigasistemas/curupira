class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_and_belongs_to_many :roles
end
