RSpec.configure do |config|
  config.include Warden::Test::Helpers, type: :feature
end
