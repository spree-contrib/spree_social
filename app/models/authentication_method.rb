class AuthenticationMethod < ActiveRecord::Base
  
  preference :provider, :string
  preference :api_key, :string
  preference :api_secret, :string
  preference :environment, :string

  #after_save :reset_devise
  #
  #private
  #
  #def reset_devise
  #  logger.debug("Self: #{self.environment}\nRails: #{RAILS_ENV}")
  #  if (self.environment == RAILS_ENV)
  #    SpreeSocial.reset_key_for(self.preferred_provider,self.preferred_api_key, self.preferred_api_secret)
  #  end
  #end
  
end
