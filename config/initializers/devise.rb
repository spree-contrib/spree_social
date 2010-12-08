Devise.setup do |config|
  
  SpreeSocial::PROVIDERS.each do |provider|
    SpreeSocial.init_provider(provider)
  end
  
end
