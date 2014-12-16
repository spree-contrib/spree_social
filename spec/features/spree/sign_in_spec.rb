RSpec.feature 'signing in using Omniauth', :js do
  context 'facebook' do
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

    scenario 'going to sign in' do
      visit spree.root_path
      click_link 'Login'
      click_facebook_link
      click_link 'Logout'
      click_link 'Login'
      click_facebook_link
    end

    # Regression test for #91
    scenario "attempting to view 'My Account' works" do
      visit spree.root_path
      click_link 'Login'
      click_facebook_link
      click_link 'My Account'
      expect(page).to have_text 'My Account'
    end
  end

  context 'twitter' do
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

    scenario 'going to sign in' do
      visit spree.root_path
      click_link 'Login'
      find('a#twitter').trigger('click')
      expect(page).to have_text 'One more step to complete your registration from Twitter'
      fill_in 'Email', with: 'user@example.com'
      click_button 'Create'
      expect(page).to have_text 'Welcome! You have signed up successfully.'
    end
  end

  private

  def click_facebook_link
    find('a#facebook').trigger('click')
    expect(page).to have_text 'You are now signed in with your facebook account.'
  end
end
