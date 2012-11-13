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

  s.add_dependency 'spree_core', '~> 1.2.0'
  s.add_dependency 'omniauth'
  s.add_dependency 'oa-core'
  s.add_dependency 'omniauth-twitter'
  s.add_dependency 'omniauth-facebook'
  s.add_dependency 'omniauth-github'
  s.add_dependency 'omniauth-google-oauth2'
end
