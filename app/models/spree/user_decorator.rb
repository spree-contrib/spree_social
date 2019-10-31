# frozen_string_literal: true

module Spree
  module UserDecorator
    def self.prepended(base)
      base.has_many :user_authentications, dependent: :destroy

      base.devise :omniauthable
    end

    def apply_omniauth(omniauth)
      skip_signup_providers = SpreeSocial::OAUTH_PROVIDERS.map { |p| p[1] if p[2] == 'true' }.compact
      if skip_signup_providers.include? omniauth['provider']
        self.email = omniauth['info']['email'] if email.blank?
      end
      user_authentications.build(provider: omniauth['provider'], uid: omniauth['uid'])
    end

    def password_required?
      (user_authentications.empty? || !password.blank?) && super
    end
  end
end

::Spree.user_class.prepend(Spree::UserDecorator)
