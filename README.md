SpreeSocial
===========

Core for all Social media related functionality for Spree. This handles authorization and account creations.


Example
=======

to get started;

rake sandbox 

add this to sandbox/Gemfile

gem 'devise', :git => 'git://github.com/plataformatec/devise.git'
gem "spree_social", :path => "../../spree_social"

rake spree_social:install
rake db:migrate

Copyright (c) 2010 [name of extension creator], released under the New BSD License
