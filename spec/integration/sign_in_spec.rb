require 'spec_helper'

feature "signing in using Omniauth" do
  before do
    Spree::AuthenticationMethod.create!(:provider => 'facebook', :environment => Rails.env, :active => true)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:facebook] = {
      'provider' => 'facebook',
      'uid' => '123545',
      'info' => {
        'name' => 'mockuser',
        'email' => 'mockuser@example.com',
        'image' => 'mock_user_thumbnail_url'
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    }
  end

  scenario "going to sign in" do
    visit spree.root_path
    click_link "Login"
    find('a[title="Login with facebook"]').click
    page.should have_content("Signed in successfully.")
  end
end