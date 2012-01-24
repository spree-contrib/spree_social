Spree::UserRegistrationsController.class_eval do
  def create
    super
    session[:omniauth] = nil unless @user.new_record?
  end

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
