class Spree::AuthenticationMethod < ActiveRecord::Base
  validates :provider, :api_key, :api_secret, presence: true

  validate :provider_must_be_backed_by_omniauth_strategy

  def self.active_authentication_methods
    where(environment: ::Rails.env, active: true)
  end

  def self.active_authentication_methods?
    active_authentication_methods.exists?
  end

  scope :available_for, lambda {|user|
    sc = where(environment: ::Rails.env)
    sc = sc.where.not(provider: user.user_authentications.pluck(:provider)) if user && !user.user_authentications.empty?
    sc
  }

  def get_social_user_info(token)
    strategy(token).auth_hash
  end

  def provider_must_be_backed_by_omniauth_strategy
    begin
      strategy_class
    rescue NameError => e
      errors.add(:provider, 'must be backed by an omniauth strategy')
    end
  end

  private

  def strategy_class
    "::OmniAuth::Strategies::#{provider.classify}".constantize
  end

  def client
    ::OAuth2::Client.new(api_key, api_secret, strategy_class.default_options.client_options.to_h).tap do |c|
      c.site = strategy_class.default_options.client_options['site']
    end
  end

  def access_token(token)
    ::OAuth2::AccessToken.new(client, token)
  end

  def strategy(token)
    app = lambda {|env| [200, {}, ["Hello World."]]}
    options = [api_key, api_secret]
    strategy_class.new(app, *options).tap {|s| s.access_token = access_token(token)}
  end
end
