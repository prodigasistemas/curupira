require "active_support/dependencies"

module Curupira
  mattr_accessor :app_root

  def self.setup
    yield self
  end
end

require "curupira/rails"
require 'cocoon'
require 'jquery-rails'
