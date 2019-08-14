module Spree
  module Api
    module V1
      module UsersControllerDecorator

        def social_login
          authentication_method = Spree::AuthenticationMethod.find_by_provider(params[:provider])
          render json: {exception: 'Unsupported provider'}, status: 422 and return unless authentication_method
          omniauth_hash = authentication_method.get_omniauth_hash(params[:oauth_token])
          authentication = Spree::UserAuthentication.find_by_provider_and_uid(params[:provider], omniauth_hash['uid'])

          if authentication.present? and authentication.try(:user).present?
            render_user_login(authentication.user)
          elsif @current_api_user
            @current_api_user.apply_omniauth(omniauth_hash)
            @current_api_user.save!
            render_user_login(@current_api_user)
          else
            user = Spree::User.find_by_email(params[:email]) || Spree::User.new
            user.apply_omniauth(omniauth_hash)
            if user.save!
              render_user_login(user)
            end
          end

          if @order
            user = @current_api_user || authentication.user
            @order.associate_user!(user)
          end
        end

        def oauth_providers
          auth_methods = Spree::AuthenticationMethod.active_authentication_methods
          auth_methods.map! do |auth_method|
            oauth_provider = SpreeSocial::OAUTH_PROVIDERS.detect {|p| p[1] == provider}
            {
                name: oauth_provider[0],
                provider: auth_method.provider,
                api_key: auth_method.api_key,
                signup_support: oauth_provider[2]
            }
          end
          render json: auth_methods, status: :ok
        end

        private

        def render_user_login(user)
          render :json => {:result => {
              :user => "#{user.login}",
              :api_key => "#{user.spree_api_key}",
              :user_id => "#{user.id}"
          }}
        end

      end
    end
  end
end

Spree::Api::V1::UsersController.prepend(Spree::Api::V1::UsersControllerDecorator)