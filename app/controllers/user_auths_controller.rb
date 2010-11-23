class UserAuthsController < ApplicationController
  def destroy
    @auth = current_user.user_auths.find(params[:id])
    @auth.destroy
    flash[:notice] = "Successfully deleted authentication source."
    redirect_to account_path
  end
end