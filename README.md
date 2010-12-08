SpreeSocial
===========

Core for all Social media related functionality for Spree. The Spree Social gem handles authorization, account creation and association through social media sources such as, Twitter and Facebook. This requires the edge source of [Spree](https://github.com/railsdog/spree). This gem is beta at best and should be treated as such. Features and code base will change rapidly as this is under active development. Use with caution.

Setup
-----

git clone https://github.com/railsdog/spree --depth 1

cd spree

rake sandbox (and get a sandwich)

git clone https://github.com/spree/spree_social --depth 1

add this to sandbox/Gemfile

gem "spree_social", :path => "../spree_social"

bundle update

rake spree_social:install

rake db:migrate

Spree Setup to Utilize OAuth Sources
------------------------------------

Login as an admin user and navigate to Configuration > Social Network Providers

Click on the New Provider button to enter the key obtained from their respective source
(See below for instructions on setting up the various providers)

Multiple key entries can now be entered based on the rails environment. This allows for portability and the lack of need to check in your key to your repository. You also have the ability to enable and disable sources. These setting will be reflected on the client UI as well.

Please note that you will still need to restart you server after entering you keys. THis is required otherwise Devise and OmniAuth will not have the key pair available to them for use.

Setup the Applications at the Respective Sources
------------------------------------------------

OAuth Applications @ Facebook, Twitter and / or Github are supported out of the box but you will need to setup applications are each respective site as follows for public use and for development. 

> All URLs must be in the form of domain.tld you may add a port as well for development

### Facebook

[Facebook](http://www.facebook.com/developers/createapp.php): [http://www.facebook.com/developers/createapp.php](http://www.facebook.com/developers/createapp.php)

1. Name the app what you will and agree to the terms.
2. Fill out the capcha
3. Under the Web Site tab
4. Site URL: http://your_computer.local:3000 for development / http://your-site.com for production
5. Site domain: your-computer.local / your-site.com respectively

Copy the Application ID and Application Secret to the config/initializers/devise.rb line for facebook

`config.omniauth :facebook, "[App_ID]", "[App_Secret]"`

### Twitter

[Twitter](http://dev.twitter.com/apps/new): [http://dev.twitter.com/apps/new](http://dev.twitter.com/apps/new)

1. Name and Description must be filled in with something
2. Application Website: http://your_computer.local:3000 for development / http://your-site.com for production
3. Application Type: Browser
4. Callback URL: http://your_computer.local:3000 for development / http://your-site.com for production
5. Default Access Type: Read & Write
6. Save Application

Copy the Consumer Key and Consumer Secret to the config/initializers/devise.rb line for twitter

`config.omniauth :twitter, "[Consumer Key]", "[Consumer Secret]"`

### Github

[Github](http://github.com/account/applications/new): [http://github.com/account/applications/new](http://github.com/account/applications/new)

1. Name The Application
2. Main URL: http://your_computer.local:3000 for development / http://your-site.com for production
3. Callback URL: http://your_computer.local:3000 for development / http://your-site.com for production
4. Click Create

Copy the Client ID and Secret to the config/initializers/devise.rb line for github

`config.omniauth :github, "[Client ID]", "[Secret]"`

> This is not a listed Github item. To View and / or edit your applications goto [http://github.com/account/applications/]([http://github.com/account/applications/])

### LinkedIn

> Coming Soon

### Google / GMail

> Coming Soon

### Yahoo!

> Coming Soon

Adding your own Auth Source
---------------------------

> Coming Soon


Copyright (c) 2010 John Brien Dilts, released under the New BSD License
