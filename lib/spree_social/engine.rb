module SpreeSocial
  OAUTH_PROVIDERS = [
    ["Facebook", "facebook"],
    ["Twitter", "twitter"],
    ["Github", "github"],
    ["Google", "google_oauth2"]
  ]

  class Engine < Rails::Engine
    engine_name 'spree_social'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer "spree_social.environment", :before => "spree.environment" do |app|
      Spree::SocialConfig = Spree::SocialConfiguration.new
    end

    initializer "spree_soclial_oauth_reconfigure", :after => :finisher_hook do |app|
      # Engines mounted at anything other than "/" cause the oath middleware to miss intercepting the request
      SpreeSocial::OAUTH_PROVIDERS.each do |provider|
        # Don't fail on non-existent strategies
        if OmniAuth::Strategies.const_defined?(provider.first)
          (OmniAuth::Strategies.const_get(provider.first)).configure do |config|
            # Reconfigure the OAuth request path to match where the engine was mounted
            if Spree::Core::Engine.routes.url_helpers.respond_to?(:spree_user_omniauth_authorize_path) # Rake tasks don't seem to have this available
              config.request_path = Spree::Core::Engine.routes.url_helpers.spree_user_omniauth_authorize_path(:provider => provider.second)
            end
          end
        end
      end
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end

  # Setup all OAuth providers
  def self.init_provider(provider)
    return unless ActiveRecord::Base.connection.table_exists?('spree_authentication_methods')
    key, secret = nil
    Spree::AuthenticationMethod.where(:environment => ::Rails.env).each do |auth_method|
      if auth_method.provider == provider
        key = auth_method.api_key
        secret = auth_method.api_secret
        Rails.logger.info("[Spree Social] Loading #{auth_method.provider.capitalize} as authentication source")
      end
    end
    self.setup_key_for(provider.to_sym, key, secret)
  end

  def self.setup_key_for(provider, key, secret)
    Devise.setup do |config|
      config.omniauth provider, key, secret, :setup => true
    end
  end
end

module OmniAuth
  module Strategies
    class Facebook < OAuth2

      MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' +
                              'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' +
                              'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' +
                              'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' +
                              'webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|' +
                              'mobile'
      def request_phase
        options[:scope] ||= "email,offline_access"
        options[:display] = mobile_request? ? 'touch' : 'page'
        super
      end

      def mobile_request?
        ua = Rack::Request.new(@env).user_agent.to_s
        ua.downcase =~ Regexp.new(MOBILE_USER_AGENTS)
      end

    end
  end
end
