	Feature: Manage posts
	  In order to duplicate twitter's functionality
	  The user
	  wants to be able to create, view, and delete posts

		Background:
			Given a valid user named "firstuser"
			And a status for "firstuser" with content "first user content"
			And a status for "firstuser" with content "second post"
			Given a valid user named "seconduser"
			Given a valid user named "test"
			And I am logged in as "test"

	
  
	  Scenario: Create status
			Given I am on the homepage
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
			
		Scenario: Create a mention
			Given I am on the homepage
			Then "firstuser" should have "0" mention(s)
			When I fill in "status_content" with "This is a reply @firstuser"
			And I press "update"
			Then "firstuser" should have "1" mention(s)
			
		Scenario: Follow a link to a mention
			Given a status for "firstuser" with content "@test this is a mention"
			And I am on the status page for "firstuser"
			When I follow "@test"
			Then I should be on the status page for "test"
			
		Scenario: Deleting a post
		  Given a status for "test" with content "This post should get deleted"
		  And I am on the status page for "test"
		  And I follow "less than a minute ago"
		  Then I should see "This post should get deleted"
		  And I should see "Delete"
		  When I follow "Delete"
		  Then I should see "Are you sure you want to delete this status?"
		  When I follow "Delete"
		  Then I should be on the status page for "test"
		  And I should not see "This post should get deleted"
		  
		Scenario: Can't delete another user's posts
		  Given a status for "seconduser" with content "This post should not get deleted"
		  And I am on the status page for "seconduser"
		  And I follow "less than a minute ago"
		  Then I should see "This post should not get deleted"
		  And I should not see "Delete"
		  
		Scenario: Create a hashtag
			Given I am on the homepage
			Then there should not be hashtag called "#testhash"
			When I fill in "status_content" with "This is a post with a #testhash"
			Given a status for "seconduser" with content "second post with same #testhash"
			And I press "update"
			Then there should be a hashtag called "#testhash"
			And "#testhash" should have "2" statuses

		Scenario: Follow a link to a hashtag
		  Given a status for "seconduser" with content "This is yet another power with #testhash"
			Given a status for "firstuser" with content "This is another post with a #testhash"
			And I am on the status page for "firstuser"
			When I follow "#testhash"
			Then I should be on the hashtag page for "testhash"
			And I should see "This is yet another power with #testhash"
			And I should see "This is another post with a #testhash"