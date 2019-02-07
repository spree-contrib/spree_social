RSpec.describe Spree::AuthenticationMethod, type: :model do
  let(:user) { create(:user) }

  describe '#available_for' do
    before do
      Spree::AuthenticationMethod.create!(provider: 'facebook', environment: Rails.env, api_key: 'test', api_secret: 'test')
    end

    context 'without users' do
      it 'returns empty association' do
        expect(described_class.available_for(nil)).to eq Spree::AuthenticationMethod.none
      end
    end
  end
end
