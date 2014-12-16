RSpec.describe Spree::User, type: :model do
  let(:user) { create(:user) }
  let(:omni_params) { { 'provider' => 'twitter', 'uid' => 12_345 } }
  let(:auths) { double 'auths' }

  context '.apply_omniauth' do
    before { allow(user).to receive(:user_authentications).and_return(auths) }

    it 'builds an associated auth source' do
      expect(auths).to receive(:build)
      user.apply_omniauth(omni_params)
    end

    context 'omniauth params contains email' do
      let(:user) { create(:user) { |user| user.email = nil } }
      let(:omni_params) { { 'provider' => 'google_oauth2', 'uid' => 12_345, 'info' => { 'email' => 'test@example.com' } } }

      it 'sets email from omniauth params' do
        expect(auths).to receive(:build)
        user.apply_omniauth(omni_params)
        expect(user.email).to eq 'test@example.com'
      end
    end
  end

  context '.password_required?' do
    before { user.password = nil }

    context 'user authentications is empty' do
      it 'returns true' do
        expect(user.password_required?).to be(true)
      end
    end

    context 'user authentications is not empty' do
      before do
        allow(user).to receive(:user_authentications).and_return(auths)
        allow(auths).to receive(:empty?).and_return(false)
      end

      it 'returns false' do
        expect(user.password_required?).to be(false)
      end
    end

    context 'when the password has been set' do
      before { user.password = 'foobar' }

      it 'returns true' do
        expect(user.password_required?).to be(true)
      end
    end
  end
end
