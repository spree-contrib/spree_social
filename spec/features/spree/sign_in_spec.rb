require 'spec_helper'

feature "signing in using Omniauth", js: true do
  context "facebook" do
    background do
      Spree::AuthenticationMethod.create!(
        provider: 'facebook',
        api_key: 'fake',
        api_secret: 'fake',
        environment: Rails.env,
        active: true)
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
      page.should have_content("You are now signed in with your facebook account.")
      click_link "Logout"
      click_link "Login"
      find('a[title="Login with facebook"]').click
      page.should have_content("You are now signed in with your facebook account.")
    end

    # Regression test for #91
    scenario "attempting to view 'My Account' works" do
      visit spree.root_path
      click_link "Login"
      find('a[title="Login with facebook"]').click
      page.should have_content("You are now signed in with your facebook account.")
      click_link 'My Account'
      page.should have_content("My Account")
    end
  end

  context "twitter" do
    background do
      Spree::AuthenticationMethod.create!(
        provider: 'twitter',
        api_key: 'fake',
        api_secret: 'fake',
        environment: Rails.env,
        active: true)
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:twitter] = {
        'provider' => 'twitter',
        'uid' => '123545',
        'info' => {
          'name' => 'mockuser',
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
      find('a[title="Login with twitter"]').click
      page.should have_content("Please confirm your email address to continue".upcase)
      fill_in "Email", :with => "user@example.com"
      click_button "Create"
      page.should have_content("Welcome! You have signed up successfully.")
    end
  end
end