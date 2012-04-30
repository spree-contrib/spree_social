# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_social'
  s.version     = '2.1.0'
  s.summary     = 'Adds social network login services (OAuth) to Spree'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'John Dyer'
  s.email             = 'john@spreecommerce.com'
  s.homepage          = 'http://www.spreecommerce.com'

  s.files         = `git ls-files`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.0.0'
  s.add_dependency 'spree_auth', '~> 1.0.0'
  s.add_dependency 'omniauth', '1.1'
  s.add_dependency 'oa-core', '~> 0.3.2'
  s.add_dependency 'omniauth-twitter', '~> 0.0.11'
  s.add_dependency 'omniauth-facebook', '~> 1.2.0'
  s.add_dependency 'omniauth-github', '~> 1.0.1'

  s.add_development_dependency 'capybara', '1.0.1'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.7'
  s.add_development_dependency 'sqlite3'
end
