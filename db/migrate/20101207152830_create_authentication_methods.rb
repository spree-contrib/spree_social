class CreateAuthenticationMethods < ActiveRecord::Migration
  def self.up
    create_table :authentication_methods, :force => true do |t|
      t.string :environment
      t.boolean :active
      t.timestamps
    end
  end

  def self.down
    drop_table :authentication_methods
  end
end
