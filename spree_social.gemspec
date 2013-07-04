# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_social'
  s.version     = '2.3.0'
  s.summary     = 'Adds social network login services (OAuth) to Spree'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'John Dyer'
  s.email             = 'jdyer@spreecommerce.com'
  s.homepage          = 'http://www.spreecommerce.com'

  s.files         = `git ls-files`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 2.1.0.beta'
  s.add_dependency 'omniauth'
  s.add_dependency 'oa-core'
  s.add_dependency 'omniauth-twitter'
  s.add_dependency 'omniauth-facebook'
  s.add_dependency 'omniauth-github'
  s.add_dependency 'omniauth-google-oauth2'

  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails', '~> 2.12.0'
  s.add_development_dependency 'factory_girl_rails', '~> 4.2.1'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'shoulda-matchers', '~> 1.0.0'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'launchy'
end
