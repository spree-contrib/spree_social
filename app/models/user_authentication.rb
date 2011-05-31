class UserAuthentication < ActiveRecord::Base
  
  belongs_to :user
  
  # Lock down authentications to a non-destructive account and login via association
  devise :omniauthable

end