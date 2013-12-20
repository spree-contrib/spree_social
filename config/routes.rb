Spree::Core::Engine.routes.draw do
  devise_for :spree_user,
             :class_name => Spree::User,
             :skip => [:unlocks, :sessions, :registrations, :passwords],
             :controllers => { :omniauth_callbacks => "spree/omniauth_callbacks" },
             :path => Spree::SocialConfig[:path_prefix]
  resources :user_authentications

  get 'account' => 'users#show', :as => 'user_root'

  namespace :admin do
    resources :authentication_methods
  end

end
