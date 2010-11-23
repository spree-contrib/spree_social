class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def facebook
    social_setups("Facebook")
  end
  
  def twitter
    social_setups("Twitter")
  end
  
  def github
    social_setups("Twitter")
  end
  
  private
  
  def social_setups(provider)
    omniauth = request.env["omniauth.auth"]
    @user_auth = UserAuth.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])

    # Prior login with this OAuth source
    if @user_auth
      flash[:notice] = t("devise.omniauth_callbacks.success", :kind => provider)
      sign_in_and_redirect(@user_auth.user, :event => :authentication)
    # Attaching an(other) OAuthable account
    elsif current_user
      current_user.user_auths.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :nickname => omniauth["user_info"]['nickname'])
      flash[:notice] = t("devise.omniauth_callbacks.success", :kind => provider)
      redirect_to(account_path)
    else
    # Never been here before
      user = User.new
      user.new_from_session(omniauth)

      if user.save! #we have all the data we need
        flash.now[:notice] = t("devise.omniauth_callbacks.success", :kind => provider)
        sign_in_and_redirect(user, :event => :authentication)
      else # We need more info
        session[:omniauth] = omniauth.except('extra')
        flash.now[:error] = t("login_failed")
        redirect_to signup_path
      end #else
    end #else
  end

end