class Spree::UserAuthenticationsController < ApplicationController
  def index
    @authentications = spree_current_user.user_authentications if spree_current_user
  end

  def destroy
    @authentication = spree_current_user.user_authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = t('removed_authentication_option', kind: @authentication.provider.capitalize)
    redirect_to spree.account_path
  end
end
