UserRegistrationsController.class_eval do
  
  def create
    session[:omniauth] = nil #unless @user.new_record?
  end
  
  def delete
    session[:omniauth] = nil
    redirect_to signin_path
  end
 
end