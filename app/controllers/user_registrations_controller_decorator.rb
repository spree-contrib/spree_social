UserRegistrationsController.class_eval do
  
  def create
    super.tap do |u|
      # User auth failue due to existing localized account
      #if User.find_by_email(params[:user][:email]) && u.session[:omniauth]
      #  
      #end
      if @user && @user.new_record?
        @omniauth = u.session[:session]
        u.session[:omniauth] = nil unless @user.new_record?
      end
    end
  end
  
  def delete
    session[:omniauth] = nil
    redirect_to signin_path
  end
 
end