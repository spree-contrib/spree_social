Spree::Core::Engine.routes.append do
  devise_for :user,
             :class_name => Spree::User,
             :skip => [:unlocks],
             :controllers => { :sessions => 'spree/user_sessions', :omniauth_callbacks => "spree/omniauth_callbacks", :registrations => 'spree/user_registrations' } do 
             	get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    			get '/users/auth/:provider/setup' => 'users/omniauth_callbacks#setup'
             end
  resources :user_authentications

  match 'account' => 'users#show', :as => 'user_root'

  namespace :admin do
    resources :authentication_methods
  end

end
