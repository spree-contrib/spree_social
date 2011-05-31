Deface::Override.new(:virtual_path => "users/show",
                     :name => "replace_account_summary_with_social_logins",
                     :replace => "[data-hook='account_summary']",
                     :partial => "users/social",
                     :disabled => false)

