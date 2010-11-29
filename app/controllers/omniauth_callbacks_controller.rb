class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include Spree::CurrentOrder
  include SpreeBase
  helper :users, 'spree/base'
  
  #after_filter :check_for_order
  
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
    #store_location
    omniauth = request.env["omniauth.auth"]
    
    if request.env["omniauth.error"].present?
      flash[:error] = t("devise.omniauth_callbacks.failure", :kind => provider, :reason => "user was not valid")
      redirect_back_or_default(login_url) 
      return
    end
    
    user = UserAuth.find_by_uid_and_provider(omniauth['uid'], omniauth['provider'])
    if current_user
      current_user.associate_auth(omniauth)
    elsif user.nil?
      user = User.anonymous!
      user.populate_from_omniauth(omniauth)
    end
    
    if current_order
      current_order.associate_user!(user)
      session[:guest_token] = nil
    end
    
    sign_in_and_redirect(user, :event => :authentication)
    
  end

end