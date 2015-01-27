RSpec.feature 'Admin Authentication Methods', :js do
  stub_authorization!

  context 'elements' do
    scenario 'has configuration tab' do
      visit spree.admin_path
      click_link 'Configuration'
      expect(page).to have_text 'Social Authentication Methods'
    end
  end

  context 'when no auth methods exists' do
    background do
      visit spree.admin_authentication_methods_path
    end

    scenario 'can create new' do
      expect(page).to have_text 'No Authentication Methods Found, Add One!'

      click_link 'New Authentication Method'
      expect(page).to have_text 'Back To Authentication Methods List'

      select2 'Test', from: 'Environment'
      select2 'Github', from: 'Social Provider'
      fill_in 'API Key', with: 'KEY123'
      fill_in 'API Secret', with: 'SEC123'

      click_button 'Create'
      expect(page).to have_text 'successfully created!'
    end

    scenario 'does not save with empty fields' do
      click_link 'New Authentication Method'
      click_button 'Create'
      expect(page).to have_text "Api key can't be blank"
    end
  end

  context 'when auth method exists' do
    given!(:authentication_method) do
      Spree::AuthenticationMethod.create!(
        provider: 'facebook',
        api_key: 'fake',
        api_secret: 'fake',
        environment: Rails.env,
        active: true)
    end

    background do
      visit spree.admin_authentication_methods_path
    end

    scenario 'can be updated' do
      within_row(1) do
        click_icon :edit
      end

      fill_in 'API Key', with: 'fake'
      fill_in 'API Secret', with: 'fake'

      click_button 'Update'
      expect(page).to have_text 'successfully updated!'
    end

    scenario 'can be deleted' do
      within_row(1) do
        click_icon :delete
      end

      page.driver.browser.switch_to.alert.accept unless Capybara.javascript_driver == :poltergeist

      expect(page).to have_text 'successfully removed!'
      expect(page).not_to have_text authentication_method.provider
    end
  end
end
