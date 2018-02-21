RSpec.feature 'signing in using Omniauth', :js do
  context 'facebook' do
    background do
      create(:authentication_method, provider: 'facebook')

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

    it 'going to sign in' do
      skip 'skip test randomly failing on Travis'
      visit spree.root_path
      click_link 'Login'
      click_facebook_link
      click_link 'Logout'
      visit spree.account_path
      expect(page).to have_text 'Login'
      click_link 'Login'
      click_facebook_link
    end

    # Regression test for #91
    scenario "attempting to view 'My Account' works" do
      visit spree.root_path
      visit spree.new_spree_user_session_path
      click_facebook_link
      visit spree.account_path
      expect(page).to have_text 'My Account'
    end
  end

  context 'twitter' do
    background do
      create(:authentication_method, provider: 'twitter')

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
      visit spree.new_spree_user_session_path
      find('a#twitter').click
      expect(page).to have_text 'One more step to complete your registration from Twitter'
      fill_in 'Email', with: 'user@example.com'
      click_button 'Create'
      expect(page).to have_text 'Welcome! You have signed up successfully.'
    end
  end

  private

  def click_facebook_link
    click_link('Login with facebook')
    expect(page).to have_text 'You are now signed in with your facebook account.'
  end
end
