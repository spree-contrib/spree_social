class Spree::AuthenticationMethod < ActiveRecord::Base
  attr_accessible :provider, :api_key, :api_secret, :environment, :active

  def self.active_authentication_methods?
    found = false
    where(:environment => ::Rails.env).each do |method|
      if method.active
        found = true
      end
    end
    return found
  end
end
