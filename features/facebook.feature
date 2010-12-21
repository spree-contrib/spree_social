Feature: Facebook Account
  In order login or associate a facebook account
  As user 
  Should be able to create an account with the credentials
    
  Scenario: User enters a new email with a facebook account
    Given I go to to the login page
    And I follow "Sign in with facebook"
    When I fill in "Email" with "username@example.com"
    And I press "Update"
    Then I should be logged in
    
  Scenario: User logs back in with facebook account
    Given I have an account with facebook
    When I go to to the login page
    And I follow "Sign in with facebook"
    Then I should be logged in
    And I should be on the account page
    And I should be logged in
    
  Scenario: User enters an existing account's email
    Given I am already signed up as "username@example.com/secret"
    Given I go to to the login page
    And I follow "Sign in with facebook"
    When I fill in "Email" with "username@example.com"
    And I press "Update"
    Then I should see "There is already an account with that email"
    When I fill in "Email" with "username@example.com"
    And I fill in "Password" with "secret"
    And I press "Log In"
    Then I should be logged in
    And I should be on the account page
