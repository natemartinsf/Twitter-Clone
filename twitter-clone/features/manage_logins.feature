Feature: Manage logins
  In order to create tweets
  As a user
  I want to be able to log in and log out
  
  Scenario: Register new login
		Given no user "FakeUser"
    And I am on the register user page
    When I fill in "Login" with "FakeUser"
		And I fill in "Email" with "fake123@fake.com"
		And I fill in "Password" with "password"
		And I fill in "Password confirmation" with "password"
		And I press "Register"
		Then I should see "Account registered!"
	
	Scenario: Logging in
	  Given a valid user   
		And I am on the login page 
	  When I submit the login form
	  Then I should see "Login successful!"
	
	Scenario: Logging in with wrong password
		Given I am on the login page
		And I submit the login form with false data
		Then I should see "Login is not valid"
