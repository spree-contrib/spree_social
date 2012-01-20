class Spree::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    auth = request.env["omniauth.auth"]
    #@user_auth = UserAuthentication.find_by_provider_and_uid(auth['provider'], auth['uid'])

    current_user.user_authentications.create(:provider => auth['provider'], :uid => auth['uid'])
    flash[:notice] = "Auth successful!"
    redirect_to user_authentications_path
  end

  def failure
    redirect_to spree.login_path
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
