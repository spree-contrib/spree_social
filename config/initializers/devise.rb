Devise.setup do |config|
  AuthenticationMethod.where(:environment => RAILS_ENV).each do |user|
    config.omniauth user.preferred_provider.to_sym, user.preferred_api_key, user.preferred_api_secret if user.preferred_enable_authentication_method
  end
end
