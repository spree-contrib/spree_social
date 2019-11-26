FactoryBot.define do
  factory :user_authentication, class: Spree::UserAuthentication do
    provider 'facebook'
    uid 'fake'
  end
end
