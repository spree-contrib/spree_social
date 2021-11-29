require 'cancan/matchers'

RSpec.describe Spree::SocialAuthenticationAbilities, type: :model do
  describe 'social configuration settings' do
    subject { described_class.new(user) }

    context 'when is ordinal user' do
      let(:user) { build_stubbed(:user) }

      it { is_expected.not_to be_able_to(:manage, Spree::SocialConfiguration) }
    end

    context 'when is admin' do
      let(:user) { build_stubbed(:admin_user) }

      it { is_expected.to be_able_to(:manage, Spree::SocialConfiguration) }
    end
  end
end
