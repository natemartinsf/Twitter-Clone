Feature: Manage users
  In order to see what my friends are doing
  The user
  wants to be able to folllow and be followed by friends
  
	Background:
		Given a valid user named "firstuser"
		And a status for "firstuser" with content "first user content"
		And a status for "firstuser" with content "second post for first user"
		Given a valid user named "seconduser"
		And a status for "seconduser" with content "second user content"
		And a status for "seconduser" with content "second post for second user"

  Scenario: Logged in user follows other user
		Given I am on the login page
    And I submit the login form for "seconduser"
    And I am on the status page for "firstuser"
	  When I press "Follow"
		Then I should see "You are now following firstuser"
		And I should be following "firstuser"
		When I am on the status page for "firstuser"
		Then I should not see "Follow"
