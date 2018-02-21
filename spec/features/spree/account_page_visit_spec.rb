RSpec.feature 'account page visit', :js do
  let(:user) { create(:user) }

  before do
    login_as(user, scope: :spree_user)
  end

  context 'with existing active authentication methods' do
    let!(:authentication_method) { create(:authentication_method) }

    before do
      visit '/account'
    end

    it 'shows possible methods to connect' do
      expect(page).to have_link(title: Spree.t(:sign_in_with, provider: authentication_method.provider))
    end

    context 'when authentication method was used' do
      before do
        create(:user_authentication, provider: authentication_method.provider, user: user)
        visit '/account'
      end

      it 'does not show used method' do
        expect(page).not_to have_link(title: Spree.t(:sign_in_with, provider: authentication_method.provider))
      end

      it 'shows method as connected' do
        expect(page).to have_text('You Have Signed In With These Services')
        expect(page).to have_text(authentication_method.provider)
      end
    end
  end
end
