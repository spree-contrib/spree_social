Spree::User.class_eval do
  has_many :user_authentications

  devise :omniauthable, :omniauth_providers => [:twitter]
end
