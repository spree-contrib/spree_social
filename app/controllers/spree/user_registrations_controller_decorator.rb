Spree::UserRegistrationsController.class_eval do
  after_action :clear_omniauth, only: :create

  private

  def build_resource(*args)
    super
    @spree_user.apply_omniauth(session[:omniauth]) if session[:omniauth]
    @spree_user
  end

  def clear_omniauth
    session[:omniauth] = nil unless @spree_user.new_record?
  end
end
