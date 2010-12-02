Rails.application.routes.draw do
  # We need to be tricky here or Devise loads up the defaults again.
  devise_for :user_authentications,
             :controllers => { :omniauth_callbacks => "omniauth_callbacks" },
             :skip => [:sessions, :registrations, :passwords, :unlocks]
  resources :user_authentications
  
end