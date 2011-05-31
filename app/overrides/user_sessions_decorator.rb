Deface::Override.new(:virtual_path => "user_sessions/new",
                     :name => "add_socials_to_login_extras",
                     :insert_after => "[data-hook='login_extras']",
                     :partial => "shared/socials",
                     :disabled => false)
