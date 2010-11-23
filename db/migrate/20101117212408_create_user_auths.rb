class CreateUserAuths < ActiveRecord::Migration
  def self.up
    create_table :user_auths do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid
      t.string :nickname
      t.timestamps
    end
  end

  def self.down
    drop_table :table_name
  end
end
