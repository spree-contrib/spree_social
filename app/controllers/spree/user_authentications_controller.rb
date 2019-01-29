class Spree::UserAuthenticationsController < Spree::BaseController
  def index
    @authentications = spree_current_user.user_authentications if spree_current_user
  end

  def destroy
    @authentication = spree_current_user.user_authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = Spree.t(:destroy, scope: :authentications)
    redirect_to spree.account_path
  end
end
