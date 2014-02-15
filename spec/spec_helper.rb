require 'simplecov'
SimpleCov.start 'rails'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../dummy/config/environment', __FILE__)

require 'rspec/rails'
require 'database_cleaner'
require 'ffaker'
require 'capybara/rspec'
require 'capybara/rails'
require 'capybara/poltergeist'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

require 'spree/testing_support/factories'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/authorization_helpers'
require 'spree/testing_support/controller_requests'
require 'spree/testing_support/url_helpers'

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false

  config.before :suite do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :truncation
  end

  config.before :each do
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end

  config.include Spree::TestingSupport::UrlHelpers
  config.include Spree::TestingSupport::ControllerRequests, :type => :controller
  config.include Devise::TestHelpers, :type => :controller
  config.include FactoryGirl::Syntax::Methods
  config.include Rack::Test::Methods, :type => :requests

  Capybara.javascript_driver = :poltergeist
end
