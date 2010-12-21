UserSessionsController.class_eval do
  
  def merge 
    # lets remove the old user here
    sign_out(:user)
    # now sign in from the login form
    authenticate_user!
    
    # prep for all the shifting and do it
    user = User.find(current_user.id)
    user.user_authentications << UserAuthentication.find(params[:user_authentication])
    user.save!
    
    # trash the old anonymous that was created
    User.destroy(params[:user][:id])
    
    # tell the truth now
    flash[:alert] = "Succesfully linked your accounts"
    sign_in_and_redirect(user, :event => :authentication)
  end
  
end