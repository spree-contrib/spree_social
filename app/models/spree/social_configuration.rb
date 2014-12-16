module Spree
  class SocialConfiguration < Preferences::Configuration
    preference :path_prefix, :string, default: 'users'
  end
end
