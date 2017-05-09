$:.push File.expand_path("../lib", __FILE__)

require "curupira/version"

Gem::Specification.new do |s|
  s.name        = "curupira"
  s.version     = Curupira::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Paulo Moura", "Felipe Iketani", "Ricardo Casseb", "Luiz Sanches"]
  s.email       = ["paulociecomp@gmail.com", "felipeiketani@gmail.com", "rcasseb@gmail.com", "luizgrsanches@gmail.com"]
  s.homepage    = "https://rubygems.org/gems/curupira"
  s.summary     = "Curupira!"
  s.description = "Easy way to authentication and authorization"
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = Dir["spec/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency 'rails', '~> 5.1', '>= 5.1.0'
  s.add_dependency "sorcery"
  s.add_dependency "cocoon"
  s.add_dependency "jquery-rails"

  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
end
