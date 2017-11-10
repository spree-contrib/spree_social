class AddDbIndexToUserAuthentications < SpreeExtension::Migration[4.2]
  def change
    add_index :spree_user_authentications, [:uid, :provider], unique: true
    add_index :spree_user_authentications, :user_id
  end
end
