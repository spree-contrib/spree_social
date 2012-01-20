class Spree::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(*providers)
    providers.each do |provider|
      class_eval %Q{
        def #{provider}
          authentication = Spree::UserAuthentication.find_by_provider_and_uid(auth_hash['provider'], auth_hash['uid'])

          if authentication
            flash[:notice] = "Signed in successfully"
            sign_in_and_redirect :user, authentication.user
          elsif current_user
            current_user.user_authentications.create!(:provider => auth_hash['provider'], :uid => auth_hash['uid'])
            flash[:notice] = "Authentication successful."
            redirect_to account_path
          else
            user = Spree::User.new
            user.apply_omniauth(auth_hash)
            if user.save
              flash[:notice] = "Signed in successfully."
              sign_in_and_redirect :user, user
            else
              session[:omniauth] = auth_hash.except('extra')
              redirect_to spree.new_user_registration_url
            end
          end
        end
      }
    end
  end

  provides_callback_for :twitter

  def failure
    redirect_to spree.login_path
  end

  def passthru
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  def auth_hash
    request.env["omniauth.auth"]
  end
end
