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
		Given a valid user named "thirduser"
		And a status for "thirduser" with content "third user content"
		And a status for "thirduser" with content "third post for second user"
		
		
  Scenario: Logged in user follows two other users
		Given I am logged in as "seconduser"
    And I am on the status page for "firstuser"
	  When I follow "Follow"
		Then I should see "You are now following firstuser"
		And I am on the status page for "firstuser"
		Then I should not see "Follow"
#		And I should be following "firstuser"
		When I am on the status page for "thirduser"
		And I follow "Follow"
		Then I should see "You are now following thirduser"
#		And I should be following "thirduser"
		
	Scenario: User stops following another user
		Given I am logged in as "firstuser"
		Given "firstuser" is following "seconduser"
		And "firstuser" is following "thirduser"
#		Then I should be following "seconduser"
#		And I should be following "thirduser"
		And I am on the status page for "seconduser"
		Then I should see "Remove"
		When I follow "Remove"
		Then I should see "You are no longer following seconduser"
#		Then I should be following "seconduser"	
		And I should not be following "seconduser"
		And I should not see "Remove"
		And I should see "Follow"
		And I should be following "thirduser"