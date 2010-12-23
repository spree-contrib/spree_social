class UserAuthenticationsController < Spree::BaseController
  
  def update
    @user = User.find(params[:id])
    @user.email = params[:user][:email]
    if @user.save
      redirect_back_or_default(product_path)
    else
      flash[:alert] = "There is already an account with that email. Please sign in to associate these accounts."
      render(:template => 'users/merge')
    end
  end
  
  def destroy
    @auth = current_user.user_authentications.find(params[:id])
    @auth.destroy
    flash[:notice] = "Successfully deleted authentication source."
    redirect_to account_path
  end
end