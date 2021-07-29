class ChangeUserIdTypeForSpreeUserAuthentications < ActiveRecord::Migration[4.2]
  def change
    change_column :spree_user_authentications, :user_id, :bigint
  end
end
