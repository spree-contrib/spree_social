Devise.setup do |config|
  
  SpreeSocial::OAUTH_PROVIDERS.each do |provider|
    SpreeSocial.init_provider(provider[1])
  end
  
end
