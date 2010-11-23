User.class_eval do
  has_many :user_auths

  def populate_from_omniauth(source)
    user_auths.build(:provider => source['provider'], :uid => source['uid'], :nickname => source["user_info"]['nickname'])

    unless (source['provider'] == 'twitter')
      self.email ||= source["extra"]["user_hash"]["email"]
    end
  end

  # Associates user to auth source
  def associate_auth(source)
    return if user_auths.where(:provider => source['provider'], :uid => source['uid']).count > 0
    self.user_auths.create!(:provider => source['provider'], :uid => source['uid'], :nickname => source["user_info"]['nickname'])
  end

  # Thx Ryan
  def password_required?
    (user_auths.empty? || !password.blank?) && super
  end

end