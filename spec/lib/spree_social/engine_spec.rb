require 'spec_helper'

describe SpreeSocial do
  context 'constants' do
    it { should be_const_defined(:OAUTH_PROVIDERS) }

    it 'contain all providers' do
      oauth_providers = [
        ["Amazon", "amazon"],
        ['Facebook', 'facebook'],
        ['Twitter', 'twitter'],
        ['Github', 'github'],
        ['Google', 'google_oauth2']]
      expect(described_class::OAUTH_PROVIDERS).to match_array oauth_providers
    end
  end
end
