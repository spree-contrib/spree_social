class UserAuthentication < ActiveRecord::Base
   
  belongs_to :user
  
  # Lockdown outhentications to a non-destructive account and login via association
  devise :omniauthable

end