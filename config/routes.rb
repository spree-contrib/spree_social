Rails.application.routes.draw do
  # We need to be tricky here or Devise loads up the defaults again.
  devise_for :user_authentications, 
             :skip => [:registrations, :passwords, :unlocks],
             :controllers => {:sessions => "user_sessions", :omniauth_callbacks => "omniauth_callbacks" }
             
  resources :user_authentications
  
  devise_for :users, :controllers => { :sessions => 'user_sessions' } do
    post "merge", :to => "user_sessions#merge", :as => "merge_user"
  end
  
  match 'account' => 'users#show', :as => 'user_root'
  
  namespace :admin do
    resources :authentication_methods
  end
  
end