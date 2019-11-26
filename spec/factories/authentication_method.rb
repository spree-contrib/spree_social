FactoryBot.define do
  factory :authentication_method, class: Spree::AuthenticationMethod do
    provider 'facebook'
    api_key 'fake'
    api_secret 'fake'
    environment { Rails.env }
    active true
  end
end
