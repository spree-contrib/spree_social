Deface::Override.new(:virtual_path => "spree/users/show",
                     :name => "add_socials_to_account_summary",
                     :insert_after => "[data-hook='account_my_orders']",
                     :partial => 'spree/users/social',
                     :disabled => false)
