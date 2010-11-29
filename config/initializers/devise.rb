Devise.setup do |config|

  # Format here is :provider, API_KEY, SECRET
  config.omniauth :facebook, "a8dd410a248298ee0e8008eec88b6d0d", "94ca0145eff74da8b79cf3692e2a67fc"
  
  # Twitter Application http://dev.twitter.com/apps/new
  # must be in the format of http://domain.tld:port
  config.omniauth :twitter, "Vp5TmS4up8XdTlHIReyhA", "e2PSsZ86jGwZzmlRfQFDlNvDFerXQNOgWIHcTEU7o"
  
  # not ready
  #config.omniauth :open_id, OpenID::Store::Filesystem.new('/tmp')
  #config.omniauth :google_apps, "Vp5TmS4up8XdTlHIReyhA", "e2PSsZ86jGwZzmlRfQFDlNvDFerXQNOgWIHcTEU7o"
  #config.omniauth :yahoo, "Vp5TmS4up8XdTlHIReyhA", "e2PSsZ86jGwZzmlRfQFDlNvDFerXQNOgWIHcTEU7o"
  #config.omniauth :linked_in, "Vp5TmS4up8XdTlHIReyhA", "e2PSsZ86jGwZzmlRfQFDlNvDFerXQNOgWIHcTEU7o"
  
  # http://github.com/account/applications/new
  config.omniauth :github, "899ae038da87f5e6667b", "97330f980865dbc3f50016c8792c6c7ec8c3f320"
  
  
end
