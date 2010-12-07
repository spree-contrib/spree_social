class AuthenticationMethod < ActiveRecord::Base
  preference :provider, :string
  preference :api_key, :string
  preference :api_secret, :string
  preference :environment, :string
  
end
