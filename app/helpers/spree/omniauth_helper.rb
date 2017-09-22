module Spree
  module OmniauthHelper
    def path_for_omniauth(user, provider)
      if Gem.loaded_specs['spree_auth_devise'].version >= Gem::Version.create('3.2.0')
        omniauth_authorize_url(user, provider)
      else
        omniauth_authorize_path(user, provider)
      end
    end
  end
end
