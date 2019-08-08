Spree::Core::Engine.add_routes do
  devise_for :spree_user,
             class_name: Spree::User,
             only: [:omniauth_callbacks],
             controllers: { omniauth_callbacks: 'spree/omniauth_callbacks' },
             path: Spree::SocialConfig[:path_prefix]
  resources :user_authentications

  get 'account' => 'users#show', as: 'user_root'

  namespace :admin do
    resources :authentication_methods
  end

  namespace :api do
    namespace :v1 do
      resources :users do
        collection do
          post :social_login
          post 'social_login/:provider', to: :social_login
          get :oauth_providers
        end
      end
    end
  end
end
