SpreeSocial
===========
[![Build Status](https://travis-ci.org/spree/spree_social.png)](https://travis-ci.org/spree/spree_social)


**NOTE: If you were contributing to the 0.70.x version of this extension, please make sure you are using the 0_70_stable branch, as this branch has recently been forced push to in order to release the 1.0.x extension rewrite.**

Core for all social media related functionality for Spree. 
The Spree Social gem handles authorization, account creation and association through social media sources such as Twitter and Facebook. 
This requires the edge source of [Spree](https://github.com/spree/spree). 
This gem is beta at best and should be treated as such. 
Features and code base will change rapidly as this is under active development. 
Use with caution.

Setup for Production
--------------------
Add this extension to your Gemfile:

```ruby
gem "spree_social", :git => "git://github.com/spree/spree_social.git"
```

Then run:

```
bundle update
rails g spree_social:install
bundle exec rake db:migrate
```

Spree Setup to Utilize OAuth Sources
------------------------------------

Login as an admin user and navigate to Configuration > Social Authentication Methods

Click on the New Authentication Method button to enter the key obtained from their respective source
(See below for instructions on setting up the various providers)

Multiple key entries can now be entered based on the rails environment. This allows for portability and the lack of need to check in your key to your repository. You also have the ability to enable and disable sources. These setting will be reflected on the client UI as well.

**You MUST restart your application after configuring or
updating an authentication method.**

Setup the Applications at the Respective Sources
------------------------------------------------

OAuth Applications @ Facebook, Twitter and / or Github are supported out of the box but you will need to setup applications are each respective site as follows for public use and for development.

> All URLs must be in the form of domain.tld you may add a port as well for development

### Facebook

[Facebook](https://developers.facebook.com/apps/?action=create): [https://developers.facebook.com/apps/?action=create](http://www.facebook.com/developers/createapp.php)

1. Name the app what you will and agree to the terms.
2. Fill out the capcha
3. Under the Web Site tab
4. Site URL: http://your_computer.local:3000 for development / http://your-site.com for production
5. Site domain: your-computer.local / your-site.com respectively

### Twitter

[Twitter](http://dev.twitter.com/apps/new): [http://dev.twitter.com/apps/new](http://dev.twitter.com/apps/new)

1. Name and Description must be filled in with something
2. Application Website: http://your_computer.local:3000 for development / http://your-site.com for production
3. Application Type: Browser
4. Callback URL: http://your_computer.local:3000 for development / http://your-site.com for production
5. Default Access Type: Read & Write
6. Save Application

### Github

[Github](http://github.com/account/applications/new): [http://github.com/account/applications/new](http://github.com/account/applications/new)

1. Name The Application
2. Main URL: http://your_computer.local:3000 for development / http://your-site.com for production
3. Callback URL: http://your_computer.local:3000 for development / http://your-site.com for production
4. Click Create

> This does not seem to be a listed Github item right now. To View and / or edit your applications goto [http://github.com/account/applications/]([http://github.com/account/applications/])

### Other OAuth sources that a currently supported

* Google (OAuth)

Setup for Development
---------------------

```
git clone git://github.com/spree/spree
git clone git://github.com/spree/spree_social
cd spree
bundle install
bundle exec rake sandbox
```

add this to sandbox/Gemfile:

```ruby
gem 'spree_social', :path => '../spree_social'
```

Then run:

```
bundle update
rails g spree_social:install
bundle exec rake db:migrate
```

Testing
-------

Inside of your cloned spree_social folder, run:

```
bundle exec rake test_app
bundle exec rspec spec
```

Adding your own Auth Source
---------------------------

> Most auth sources supported by the Omniauth gem can be added. I attempt to keep the popular ones included and tested.

Copyright (c) 2012 John Brien Dilts, released under the New BSD License
