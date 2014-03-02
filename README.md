SpreeSocial
===========

[![Build Status](https://api.travis-ci.org/spree/spree_social.png)](https://travis-ci.org/spree/spree_social)
[![Code Climate](https://codeclimate.com/github/spree/spree_social.png)](https://codeclimate.com/github/spree/spree_social)

Core for all social media related functionality for Spree.
The Spree Social gem handles authorization, account creation and association through social media sources such as Twitter and Facebook.
This requires the edge source of [Spree][1].
This gem is beta at best and should be treated as such.
Features and code base will change rapidly as this is under active development.
Use with caution.

Setup for Production
--------------------

Add this extension to your `Gemfile`:
```ruby
gem 'spree_social', github: 'spree/spree_social', branch: 'master'
```

Then run:
```sh
$ bundle update
$ rails g spree_social:install
$ bundle exec rake db:migrate
```

Preference(optional): By default url will be '/users/auth/:provider'. If you wish to modify the url to: '/member/auth/:provider', '/profile/auth/:provider', or '/auth/:provider' then you can do this accordingly in your **config/initializers/spree.rb** file as described below -

```ruby
Spree::SocialConfig[:path_prefix] = 'member' # for /member/auth/:provider
Spree::SocialConfig[:path_prefix] = 'profile' # for /profile/auth/:provider
Spree::SocialConfig[:path_prefix] = '' # for /auth/:provider
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

[Facebook / Developers / Apps][2]

1. Name the app what you will and agree to the terms.
2. Fill out the capcha
3. Under the Web Site tab
4. Site URL: http://your_computer.local:3000 for development / http://your-site.com for production
5. Site domain: your-computer.local / your-site.com respectively

### Twitter

[Twitter / Application Management / Create an application][3]

1. Name and Description must be filled in with something
2. Application Website: http://your_computer.local:3000 for development / http://your-site.com for production
3. Application Type: Browser
4. Callback URL: http://your_computer.local:3000 for development / http://your-site.com for production
5. Default Access Type: Read & Write
6. Save Application

### Github

[Github / Applications / Register a new OAuth application][4]

1. Name The Application
2. Main URL: http://your_computer.local:3000 for development / http://your-site.com for production
3. Callback URL: http://your_computer.local:3000 for development / http://your-site.com for production
4. Click Create

> This does not seem to be a listed Github item right now. To View and / or edit your applications goto [http://github.com/account/applications](http://github.com/account/applications)

### Other OAuth sources that a currently supported

* Google (OAuth)

---

## Contributing

In the spirit of [free software][5], **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using prerelease versions
* by reporting [bugs][6]
* by suggesting new features
* by writing translations
* by writing or editing documentation
* by writing specifications
* by writing code (*no patch is too small*: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues][6]
* by reviewing patches

Starting point:

* Fork the repo
* Clone your repo
* Run `bundle install`
* Run `bundle exec rake test_app` to create the test application in `spec/test_app`
* Make your changes
* Ensure specs pass by running `bundle exec rspec spec`
* Submit your pull request

Copyright (c) 2014 [John Dyer][7] and [contributors][8], released under the [New BSD License][9]

[1]: https://github.com/spree/spree
[2]: https://developers.facebook.com/apps/?action=create
[3]: https://apps.twitter.com/app/new
[4]: https://github.com/settings/applications/new
[5]: http://www.fsf.org/licensing/essays/free-sw.html
[6]: https://github.com/spree/spree_social/issues
[7]: https://github.com/LBRapid
[8]: https://github.com/spree/spree_social/graphs/contributors
[9]: https://github.com/spree/spree_social/blob/master/LICENSE.md
