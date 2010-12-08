User.class_eval do
  has_many :user_authentications

  def populate_from_omniauth(source)
    return if user_authentications.where(:provider => source['provider'], :uid => source['uid'].to_s).count > 0
    user_authentications.build(:provider => source['provider'], :uid => source['uid'], :nickname => source["user_info"]['nickname'])

    unless (source['provider'] == 'twitter')
      self.email ||= source["extra"]["user_hash"]["email"]
    end
  end

  # Associates user to auth source
  def associate_auth(source)
    return if user_authentications.where(:provider => source['provider'], :uid => source['uid'].to_s).count > 0
    self.user_authentications.create!(:provider => source['provider'], :uid => source['uid'], :nickname => source["user_info"]['nickname'])
  end

  # Thx Ryan
  def password_required?
    (user_authentications.empty? || !password.blank?) && super
  end

end