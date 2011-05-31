Deface::Override.new(:virtual_path => "user_registrations/new",
                     :name => "add_socials_to_login_extras",
                     :insert_after => "[data-hook='login_extras']",
                     :partial => "shared/socials",
                     :disabled => false)

Deface::Override.new(:virtual_path => "user_registrations/new",
                     :name => "add_omni_auth_to_signup_inside_form",
                     :replace => "[data-hook='signup_inside_form']",
                     :partial => "user_registrations/omni_auth_form",
                     :disabled => false)


Deface::Override.new(:virtual_path => "user_registrations/new",
                     :name => "add_replace_login_as_existing_link",
                     :replace => "code[erb-loud]:contains('login_as_existing')",
                     :text => %q{<%= session[:omniauth] ? link_to( t("login_as_existing"), user_registration_path, :method => :delete) : link_to( t("login_as_existing"), login_path) %>},
                     :disabled => false)

