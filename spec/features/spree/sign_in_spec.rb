RSpec.feature 'signing in using Omniauth', :js do
  context 'wonderful union' do
    background do
      Spree::AuthenticationMethod.create!(
        provider: 'wonderful_union',
        api_key: 'fake',
        api_secret: 'fake',
        environment: Rails.env,
        active: true)
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:wonderful_union] = {
        'provider' => 'wonderful_union',
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
      find('a#wonderful-union').trigger('click')
      expect(page).to have_text 'You are now signed in with your wonderful_union account.'
    end
  end
end
