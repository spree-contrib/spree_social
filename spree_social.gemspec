lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_social/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_social'
  s.version     = SpreeSocial.version
  s.summary     = 'Adds social network login services (OAuth) to Spree'
  s.description = s.summary
  s.required_ruby_version = '>= 2.1.0'

  s.author   = 'John Dyer'
  s.email    = 'jdyer@spreecommerce.com'
  s.homepage = 'http://www.spreecommerce.com'
  s.license  = 'BSD-3'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_runtime_dependency 'spree_core', '>= 3.1.0', '< 4.0'
  s.add_runtime_dependency 'spree_auth_devise', '>= 3.1.0', '< 4.0'
  s.add_runtime_dependency 'spree_extension'
  s.add_runtime_dependency 'omniauth'
  s.add_runtime_dependency 'oa-core'
  s.add_runtime_dependency 'omniauth-twitter'
  s.add_runtime_dependency 'omniauth-facebook'
  s.add_runtime_dependency 'omniauth-github'
  s.add_runtime_dependency 'omniauth-google-oauth2'
  s.add_runtime_dependency 'omniauth-amazon'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-screenshot'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'appraisal'
  s.add_development_dependency 'pg', '~> 0.18'
  s.add_development_dependency 'mysql2', '~> 0.5.1'
  s.add_development_dependency 'puma'
end
