Rails.application.routes.draw do
  # We need to be tricky here or Devise loads up the defaults again.
  devise_for :user_authentications, 
             :skip => [:registrations, :unlocks],
             :controllers => {:passwords => "user_passwords",
                              :sessions => "user_sessions",
                              :omniauth_callbacks => "omniauth_callbacks" } do
    post "merge", :to => "user_sessions#merge", :as => "merge_user"
  end

  resources :user_authentications
  
  match 'account' => 'users#show', :as => 'user_root'
  
  namespace :admin do
    resources :authentication_methods
  end
  
end