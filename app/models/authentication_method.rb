class AuthenticationMethod < ActiveRecord::Base
  PROVIDERS = [
    "facebook",
    "twitter",
    "github"
  ]
  
  preference :provider, :string
  preference :api_key, :string
  preference :api_secret, :string
  preference :environment, :string
  preference :enable_authentication_method
end
