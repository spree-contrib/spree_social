class CreateAuthenticationMethods < SpreeExtension::Migration[4.2]
  def change
    create_table :spree_authentication_methods do |t|
      t.string :environment
      t.string :provider
      t.string :api_key
      t.string :api_secret
      t.boolean :active
      t.timestamps null: false
    end
  end
end
