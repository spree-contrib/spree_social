Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_social'
  s.version     = '1.3'
  s.summary     = 'Adds social network login services (OAuth) to Spree'
  #s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 1.8.7'

  s.author            = 'John Brien Dilts'
  s.email             = 'jdilts@railsdog.com'
  s.homepage          = 'http://spreecommerce.com'

  s.files        = Dir['CHANGELOG', 'README.md', 'LICENSE', 'lib/**/*', 'app/**/*', 'db/**/*', 'public/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  #s.add_dependency('spree_core', '>= 0.60.0.RC1')
  s.add_dependency('spree_auth', '>= 0.60.1')
  s.add_dependency('oa-oauth', ">= 0.2.6") # we don't need all of the omniauth family just the oAuth stuff'

end
