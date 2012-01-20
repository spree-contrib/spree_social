class Spree::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    auth = request.env["omniauth.auth"]
    authentication = Spree::UserAuthentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
    if authentication
      flash[:notice] = "Signed in successfully"
      sign_in_and_redirect :user, authentication.user
    elsif current_user
      current_user.user_authentications.create!(:provider => auth['provider'], :uid => auth['uid'])
      flash[:notice] = "Authentication successful."
      redirect_to user_authentications_url
    else
      user = Spree::User.new
      user.apply_omniauth(auth)
      if user.save
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect :user, user
      else
        session[:omniauth] = auth.except('extra')
        redirect_to spree.new_user_registration_url
      end
    end
  end

  def failure
    redirect_to spree.login_path
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end
end
