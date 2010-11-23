class SocialHooks < Spree::ThemeSupport::HookListener
  replace :account_summary , 'users/social'
  insert_after :login_extras, 'shared/socials'
end
