SpreeSocial
===========

Core for all Social media related functionality for Spree. The Spree Social gem handles authorization, account creation and association through social media sources such as, Twitter and Facebook. This requires the edge source of [Spree](https://github.com/railsdog/spree). This gem is beta at best and should be treated as such. Features and code base will change rapidly as this is under active development. Use with caution.

Setup for Production
--------------------
Add this to your gem file Gemfile

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

Please note that you will still need to restart you server after entering you keys. This is required otherwise Devise and OmniAuth will not have the key pair available to them for use. Also if you are running Spree with SSL, make sure you setup you applications at the social network of you choice EXACTLY as it in seen in the browser, OAuth will fail if it experiences a local redirect through the various handshakes (e.g. if you have https://www.example.com as your domain for SSL, that is the URL that need to be uses as the domain at the OAuth source of your choice).

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

### 37 Signals

[37 Signals](https://integrate.37signals.com): [https://integrate.37signals.com](https://integrate.37signals.com)

> This include Basecamp, HighRise, Campfire, and Backpack. It is referred to as Basecamp in the admin

1. Name The Application, Your Company, and Your URL
2. Check one or all of the 37 Signals apps you use
3. Redirect URI (at the bottom of the page) http://your_computer.local:3000

### Other OAuth sources that a currently supported

* Bit.ly
* Evernote
* Foursquare
* Google (OAuth)
* Gowalla
* instagr.am
* Instapaper
* LinkedIn
* Vimeo
* Yahoo!
* YouTube

Setup for Development
---------------------

git clone git://github.com/railsdog/spree --depth 1

cd spree

rake sandbox (and get a sandwich)

git clone git://github.com/spree/spree_social --depth 1

add this to sandbox/Gemfile

gem "spree_social", :path => "../spree_social"

bundle update

rake spree_social:install

rake db:migrate

Testing
-------

rake testapp inside of cloned spree_social folder

cucumber features

rspec spec


Adding your own Auth Source
---------------------------

> Most auth sources supported by the Omniauth gem can be added. I attempt to keep the popular ones included and tested.


Copyright (c) 2010 John Brien Dilts, released under the New BSD License
