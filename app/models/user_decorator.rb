User.class_eval do
  has_many :user_auths

  #def build_user_auth(omniauth)
  #  self.email = omniauth['user_info']['email'] if email.blank?
  #  user_auths.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  #end

  def new_from_session(session)
    logger.debug(session["user_info"].to_yaml)
    user_auths.build(:provider => session['provider'], :uid => session['uid'], :nickname => session["user_info"]['nickname'])

    if (session['provider'] == 'twitter')
      token = User.generate_token(:persistence_token)
      self.email = "#{token}@example.net"
    else
      self.email = session["extra"]["user_hash"]["email"] if email.blank?
    end
  end

  # Thx Ryan
  def password_required?
    (user_auths.empty? || !password.blank?) && super
  end

end