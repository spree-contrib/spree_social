source 'http://rubygems.org'

group :test do
  gem 'ffaker'
end

if RUBY_VERSION < "1.9"
  gem "ruby-debug"
else
  gem "debugger"
end

# TODO: Remove from Gemfile  add to gemspec once gem is released
gem 'spree_auth_devise', :git => 'git://github.com/spree/spree_auth_devise.git'

gemspec
