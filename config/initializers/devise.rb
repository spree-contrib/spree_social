Devise.setup do |config|
  
  SpreeSocial::OAUTH_PROVIDERS.each do |provider|
    SpreeSocial.init_provider(provider)
  end
  
end
