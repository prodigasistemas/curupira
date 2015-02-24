class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates_presence_of :email
end
