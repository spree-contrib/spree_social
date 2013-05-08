class Spree::UserAuthenticationsController < ApplicationController
  def index
    @authentications = spree_current_user.user_authentications if spree_current_user
  end

  def destroy
    @authentication = spree_current_user.user_authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication method."
    redirect_to spree.account_path
  end
end
