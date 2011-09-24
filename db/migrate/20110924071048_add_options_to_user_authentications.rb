class AddOptionsToUserAuthentications < ActiveRecord::Migration
  def self.up
    add_column :user_authentications, :options, :text
  end

  def self.down
    remove_column :user_authentications, :options
  end
end
