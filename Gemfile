source 'http://rubygems.org'

# TODO: Remove from Gemfile  add to gemspec once gem is released
gem 'spree', :git => 'git://github.com/spree/spree', :branch => '1-3-stable'
# Should be using 1-3-stable branch, but namespacing changes in spree_auth_devise from commit 4a27c35fd29cf4fcafc1cf6b2401d937361610b9 break spree_social, so locking to this known working commit
gem 'spree_auth_devise', :git => 'git://github.com/spree/spree_auth_devise.git', ref: 'ccd6a'#, :branch => '1-3-stable'

gemspec
