Deface::Override.new(:virtual_path => "spree/user_sessions/new",
                     :name => "add_socials_to_login_extras",
                     :insert_after => "[data-hook='login_extras']",
                     :partial => "spree/shared/socials",
                     :disabled => false)
