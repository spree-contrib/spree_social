class UserAuthentication < ActiveRecord::Base
   
  belongs_to :user
  
  # Lockdown outhentications to a non-destructive account and login via association
  devise :omniauthable
  
  def self.reload_omniauth_settings
    AuthenticationMethod.where(:environment => RAILS_ENV).each do |user|
      Devise.omniauth user.preferred_provider.to_sym, user.preferred_api_key, user.preferred_api_secret
      Devise.include_helpers(UserAuthenticationsController)
      #Devise::OmniAuth::Config.new(user.preferred_provider.to_sym, {user.preferred_api_key, user.preferred_api_secret})
      #Devise.setup do |config|
      #  config.omniauth user.preferred_provider.to_sym, user.preferred_api_key, user.preferred_api_secret if user.preferred_enable_authentication_method
      #end
      #Devise::OmniAuth::UserHelpers.define_helpers("user_authentications")
    end
  end
  
  
end