class Spree::Api::V1::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  skip_before_action :verify_authenticity_token
  before_action :validate_provider, only: :login

  def login
    authentication = Spree::UserAuthentication.find_by_provider_and_uid(auth_hash['provider'], auth_hash['uid'])

    if authentication.present? && authentication.try(:user).present?
      access_token(authentication.user)
    elsif spree_current_user
      spree_current_user.apply_omniauth(auth_hash)
      spree_current_user.save!
      access_token(spree_current_user)
    else
      user = Spree::User.find_by_email(auth_hash['info']['email']) || Spree::User.new
      user.apply_omniauth(auth_hash)
      if user.save
        access_token(user).body
      else
        render json: { error: I18n.t('spree.user_was_not_valid') }, status: 422 and return
      end
    end
    render json: @token_response.body, status: 200
  end

  def access_token(user)
    access_token = Doorkeeper::AccessToken.create!({
      resource_owner_id: user.id,
      expires_in: Doorkeeper.configuration.access_token_expires_in,
      use_refresh_token: Doorkeeper.configuration.refresh_token_enabled?
    })
    @token_response = Doorkeeper::OAuth::TokenResponse.new(access_token)
  end

  def auth_hash
    params[:omniauth_callback]
  end

  def validate_provider
    eligible_providers = SpreeSocial::OAUTH_PROVIDERS.map { |provider| provider[1] if provider[2] == 'true' }.compact

    unless eligible_providers.include?(auth_hash['provider'])
      render json: { error: I18n.t('devise.omniauth_callbacks.provider_not_found', kind: auth_hash['provider']) },
             status: 422
    end
  end
end
