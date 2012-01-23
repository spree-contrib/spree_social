Spree::Core::Engine.routes.append do
  devise_for :users,
             :class_name => Spree::User,
             :skip => [:unlocks],
             :controllers => { :sessions => 'spree/user_sessions', :omniauth_callbacks => "spree/omniauth_callbacks", :registrations => 'spree/user_registrations' }
  resources :user_authentications

  match 'account' => 'users#show', :as => 'user_root'

  namespace :admin do
    resources :authentication_methods
  end

end
