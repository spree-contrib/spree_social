Spree::UserRegistrationsController.class_eval do
  private

  def build_resource(*args)
    super
    if session[:omniauth]
      @user.apply_omniauth(session[:omniauth])
      @user.valid?
      @user
    end
  end
end
