require 'stringex'

class Spree::AuthenticationMethod < ActiveRecord::Base
  validates :provider, :api_key, :api_secret, presence: true

  def self.active_authentication_methods?
    where(environment: ::Rails.env, active: true).exists?
  end

  scope :available_for, lambda { |user|
    return none unless user

    sc = where(environment: ::Rails.env)
    sc = sc.where.not(provider: user.user_authentications.pluck(:provider)) unless user.user_authentications.empty?
    sc
  }
end
