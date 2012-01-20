class Spree::UserAuthenticationsController < ApplicationController
  def index
    @authentications = current_user.user_authentications if current_user
  end

  def destroy
    @authentication = current_user.user_authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication method."
    redirect_to user_authentications_url
  end
end
