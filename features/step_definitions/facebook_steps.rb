Then /^I should be logged in$/ do
  page.should have_content("Logout")
end

Given /^I am already signed up as "(.+)\/(.+)"$/ do |email, password|
  @user = User.create!(
    :email                 => email,
    :password              => password,
    :password_confirmation => password)
end

Given /^I have an account with facebook$/ do
  @user = User.create!(
     :email                 => 'boy@bubble.com',
     :password              => 'tinybubbles',
     :password_confirmation => 'tinybubbles')
  @user.user_authentications << UserAuthentication.create!(
      :provider => 'facebook',
      :uid => '111xxx222yyy333zzz',
      :nickname => 'bubbleboy'
      )
  @user.save!
end
