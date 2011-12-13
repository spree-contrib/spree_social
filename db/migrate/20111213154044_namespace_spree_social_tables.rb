class NamespaceSpreeSocialTables < ActiveRecord::Migration
  def change
    rename_table :user_authentications,   :spree_user_authentications
    rename_table :authentication_methods, :spree_authentication_methods
  end
end
