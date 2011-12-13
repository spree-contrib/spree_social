Deface::Override.new(:virtual_path => "spree/admin/shared/_configuration_menu",
                     :name => "add_social_providers_link_configuration_menu",
                     :insert_bottom => "[data-hook='admin_configurations_sidebar_menu']",
                     :text => %q{<%= configurations_sidebar_menu_item t("social_servers"), admin_authentication_methods_path %>},
                     :disabled => false)

Deface::Override.new(:virtual_path => "spree/admin/configurations/index",
                     :name => "add_social_providers_to_configuration_menu",
                     :insert_after => "[data-hook='admin_configurations_menu']",
                     :partial => "spree/admin/shared/configurations_menu",
                     :disabled => false)

