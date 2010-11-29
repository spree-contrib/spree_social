Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_social'
  s.version     = '1.0.0'
  s.summary     = 'Add gem summary here'
  #s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 1.8.7'

  # s.author            = 'David Heinemeier Hansson'
  # s.email             = 'david@loudthinking.com'
  # s.homepage          = 'http://www.rubyonrails.org'
  # s.rubyforge_project = 'actionmailer'

  s.files        = Dir['CHANGELOG', 'README.md', 'LICENSE', 'lib/**/*', 'app/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.has_rdoc = true

  s.add_dependency('spree_core', '>= 0.40.0')
  s.add_dependency('spree_auth', '>= 0.40.0')
  s.add_dependency('devise', '1.2.rc')
  s.add_dependency('oa-oauth', '>= 0.1.6')
end