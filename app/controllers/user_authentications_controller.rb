class UserAuthenticationsController < Spree::BaseController

  def update
    @user = User.find(params[:id])

    authorize! :edit, @user, session[:user_access_token]

    session[:user_access_token] = nil

    @user.email = params[:user][:email]
    if @user.save
      sign_in(@user, :event => :authentication) unless current_user
      redirect_back_or_default(products_path)
    else
<<<<<<< HEAD
      flash.now[:error] = "There is already an account with that email. Please sign in to associate these accounts."
=======
      flash.now[:error] = I18n.t(:sign_in_to_associate_with_existing_email)
>>>>>>> Merge branch 'master' of github.com:spree/spree_social
      render(:template => 'users/merge')
    end
  end

  def destroy
    @auth = current_user.user_authentications.find(params[:id])

    authorize! :destroy, @auth

    @auth.destroy
<<<<<<< HEAD
    flash[:notice] = "Successfully deleted authentication source."
=======
    flash[:notice] = I18n.t(:successfully_deleted_authentication_source)
>>>>>>> Merge branch 'master' of github.com:spree/spree_social
    redirect_to account_path
  end
end
