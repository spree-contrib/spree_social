class SocialHooks < Spree::ThemeSupport::HookListener
  replace :account_summary , 'users/social'
  insert_after :login_extras, 'shared/socials'
  insert_after :admin_configurations_sidebar_menu, 'admin/shared/sidebar_menu'
  insert_after :admin_configurations_menu, 'admin/shared/configurations_menu'
  
end
