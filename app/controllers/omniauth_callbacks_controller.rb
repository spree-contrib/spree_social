class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Spree::CurrentOrder
  include SpreeBase
  helper :users, 'spree/base'

  def facebook
    social_setups("Facebook")
  end

  def twitter
    social_setups("Twitter")
  end

  def github
    social_setups("Github")
  end

  private

  def social_setups(provider)
    omniauth = request.env["omniauth.auth"]
    
    if request.env["omniauth.error"].present?
      flash[:error] = t("devise.omniauth_callbacks.failure", :kind => provider, :reason => "user was not valid")
      redirect_back_or_default(root_url)
      return
    end

    if existing_auth = UserAuthentication.where(:provider => omniauth['provider'], :uid => omniauth['uid'].to_s).first
      user = existing_auth.user
    else
      user = current_user
    end

    user ||= User.anonymous!

    user.associate_auth(omniauth) unless UserAuthentication.where(:provider => omniauth['provider'], :uid => omniauth['uid'].to_s).first

    if current_order
      current_order.associate_user!(user)
      session[:guest_token] = nil
    end

    current_user ? redirect_back_or_default(account_url) : sign_in_and_redirect(user, :event => :authentication)
  end

end