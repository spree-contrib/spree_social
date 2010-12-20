Then /^I should be logged in$/ do
  page.should have_content("Logout")
end

Given /^I am already signed up as "(.+)\/(.+)"$/ do |email, password|
  @user = User.create!(
    :email                 => email,
    :password              => password,
    :password_confirmation => password)
end

Then /^I should be asked to login with my password$/ do
  pending # express the regexp above with the code you wish you had
end

