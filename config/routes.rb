SpreeSocial::Engine.routes.draw do
  # We need to be tricky here or Devise loads up the defaults again.
  devise_for :user_authentications,
             :class_name => Spree::UserAuthentication,
             :skip => [:registrations, :unlocks],
             :controllers => {:passwords => "user_passwords",
                              :sessions => "user_sessions",
                              :omniauth_callbacks => "omniauth_callbacks" } do
    post "merge", :to => "user_sessions#merge", :as => "merge_user"
  end
end
