source 'http://rubygems.org'

group :test do
  gem 'ffaker'
end

if RUBY_VERSION < "1.9"
  gem "ruby-debug"
else
  gem "debugger"
end

group :development, :test do
  gem 'pry'
  gem 'sqlite3'
end

group :test do
  gem 'rspec-rails', '~> 2.9.0'
  gem 'factory_girl_rails', '~> 1.7.0'
  gem 'ffaker'
  gem 'shoulda-matchers', '~> 1.0.0'
  gem 'capybara'
end

# TODO: Remove from Gemfile  add to gemspec once gem is released
gem 'spree_auth_devise', :git => 'git://github.com/spree/spree_auth_devise.git'

gemspec
