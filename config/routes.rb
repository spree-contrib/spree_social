Spree::Core::Engine.routes.append do
  # We need to be tricky here or Devise loads up the defaults again.
  devise_for :user_authentications,
             :class_name => 'Spree::UserAuthentication',
             :skip => [:registrations, :unlocks],
             :controllers => {:passwords => "spree/user_passwords",
                              :sessions => "spree/user_sessions",
                              :omniauth_callbacks => "spree/omniauth_callbacks" } do
    post "merge", :to => "user_sessions#merge", :as => "merge_user"
  end

  resources :user_authentications

  match 'account' => 'users#show', :as => 'user_root'

  namespace :admin do
    resources :authentication_methods
  end

end
