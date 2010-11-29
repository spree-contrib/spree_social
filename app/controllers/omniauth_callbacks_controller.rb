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
      redirect_back_or_default(root_url) 
      return
    end
    
    user = current_user
    if user
      user.associate_auth(omniauth)
    else
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