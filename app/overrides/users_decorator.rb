Deface::Override.new(:virtual_path => "spree/users/show",
                     :name => "replace_account_summary_with_social_logins",
                     :replace => "[data-hook='account_summary']",
                     :partial => "spree/users/social",
                     :disabled => false)

