class Spree::AuthenticationMethod < ActiveRecord::Base
  attr_accessible :provider, :api_key, :api_secret, :environment, :active

  def self.active_authentication_methods?
    where(:environment => ::Rails.env, :active => true).exists?
  end

  scope :available_for, lambda { |user|
    sc = where(:environment => ::Rails.env)
    sc = sc.where(["provider NOT IN (?)", user.user_authentications.map(&:provider)]) if user and !user.user_authentications.empty?
    sc
  }
end
