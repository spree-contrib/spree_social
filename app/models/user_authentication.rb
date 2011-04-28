class UserAuthentication < ActiveRecord::Base
  
  belongs_to :user
  
  # Lock down authentications to a non-destructive account and login via association
  devise :omniauthable, :omniauth_providers => SpreeSocial::OAUTH_PROVIDERS.each {|provider| provider[1].to_sym}

end