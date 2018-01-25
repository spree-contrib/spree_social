module SpreeSocial
  OAUTH_PROVIDERS = [
    %w(Facebook facebook true),
    %w(Twitter twitter false),
    %w(Github github false),
    %w(Google google_oauth2 true),
    %w(Amazon amazon false)
  ]

  class Engine < Rails::Engine
    engine_name 'spree_social'

    config.autoload_paths += %W(#{config.root}/lib)

    # Resolves omniauth_callback error on development env
    # See https://github.com/spree-contrib/spree_social/issues/193#issuecomment-296585601
    if Rails::VERSION::MAJOR == 5
      initializer 'main_app.auto_load' do |app|
        Rails.application.reloader.to_run(:before) do
          Rails.application.reloader.prepare!
        end
      end
    end

    initializer 'spree_social.environment', before: 'spree.environment' do
      Spree::SocialConfig = Spree::SocialConfiguration.new
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end

      Spree::Ability.register_ability(Spree::SocialAuthenticationAbilities)
    end

    config.to_prepare(&method(:activate).to_proc)
  end

  # Setup all OAuth providers
  def self.init_provider(provider, scope='email')
    return unless ActiveRecord::Base.connection_pool.with_connection { |con| con.active? }  rescue false
    return unless ActiveRecord::Base.connection.data_source_exists?('spree_authentication_methods')
    key, secret = nil
    Spree::AuthenticationMethod.where(environment: ::Rails.env).each do |auth_method|
      next unless auth_method.provider == provider
      key = auth_method.api_key
      secret = auth_method.api_secret
      Rails.logger.info("[Spree Social] Loading #{auth_method.provider.capitalize} as authentication source")
    end
    setup_key_for(provider.to_sym, key, secret, scope)
  end

  def self.setup_key_for(provider, key, secret, scope)
    Devise.setup do |config|
      config.omniauth provider, key, secret, setup: true, scope: scope, info_fields: 'email, name'
    end
  end
end

module OmniAuth
  module Strategies
    class Facebook < OAuth2
      MOBILE_USER_AGENTS =  'palm|blackberry|nokia|phone|midp|mobi|symbian|chtml|ericsson|minimo|' \
                            'audiovox|motorola|samsung|telit|upg1|windows ce|ucweb|astel|plucker|' \
                            'x320|x240|j2me|sgh|portable|sprint|docomo|kddi|softbank|android|mmp|' \
                            'pdxgw|netfront|xiino|vodafone|portalmmm|sagem|mot-|sie-|ipod|up\\.b|' \
                            'webos|amoi|novarra|cdm|alcatel|pocket|ipad|iphone|mobileexplorer|' \
                            'mobile'
      def request_phase
        options[:scope] ||= 'email'
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
