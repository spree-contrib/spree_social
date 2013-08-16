# More on Spree's preference configuration - http://guides.spreecommerce.com/preferences.html#site_wide_preferences
module Spree
  class SocialConfiguration < Preferences::Configuration
    preference :path_prefix, :string, :default => 'users'
  end
end
