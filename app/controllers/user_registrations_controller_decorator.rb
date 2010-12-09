UserRegistrationsController.class_eval do
  
  def create
    super.tap do |u|
      if @user && @user.new_record?
        u.session[:omniauth] = nil unless @user.new_record?
      end
    end
  end
  
  def delete
    session[:omniauth] = nil
    redirect_to signin_path
  end
 
end