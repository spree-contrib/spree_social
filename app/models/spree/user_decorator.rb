Spree::User.class_eval do
  has_many :user_authentications

  devise :omniauthable

  def apply_omniauth(omniauth)
    user_authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
end
