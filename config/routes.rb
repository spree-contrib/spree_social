Rails.application.routes.draw do
  # We need to be tricky here or Devise loads up the defaults again.
#  devise_for :user_authentications,
#
#             :controller => {  }
             
  resources :user_authentications
  
  devise_for :user_authentications,
             :skip => [:registrations, :unlocks],
             :controllers => {:omniauth_callbacks => "omniauth_callbacks", :sessions => 'user_sessions' } do
    post "merge", :to => "user_sessions#merge", :as => "merge_user"
  end
  
  match 'account' => 'users#show', :as => 'user_root'
  
  namespace :admin do
    resources :authentication_methods
  end
  
end