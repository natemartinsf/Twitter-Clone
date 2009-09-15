Feature: Manage posts
  In order to duplicate twitter's functionality
  The user
  wants to be able to create, view, and delete posts

	Background:
		Given a valid user named "firstuser"
		And a status for "firstuser" with content "first user content"
		And a status for "firstuser" with content "second post"
		Given a valid user named "test"
		And I am on the login page 
		And I submit the login form for "test"
		And I am on the status page for "test"
	
  
  Scenario: Create status
    When I fill in "status_content" with "Test Post 1234"
		And I press "update"
		Then I should see "Test Post 1234"
		
	Scenario: Visit other user's status page
		Given I am on the status page for "firstuser"
		Then I should see "first user content"
		And I should not see "What's up?"
		
	Scenario: Visit status detail page
		Given I am on the status page for "firstuser"
		And I follow "less than a minute ago"
		Then I should see "first user content"
		And I should not see "second post"