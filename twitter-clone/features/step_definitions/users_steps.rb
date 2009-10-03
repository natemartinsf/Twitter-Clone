Then /^I should be following "([^\"]*)"$/ do |login|
  followed = User.find(:first,
                  :conditions => ["login = ?", login])
  @custom_user.is_following?(followed).should == true
end


Then /^I should not be following "([^\"]*)"$/ do |login|
  followed = User.find(:first,
                  :conditions => ["login = ?", login])
  @custom_user.is_following?(followed).should == false
end


Given /^"([^\"]*)" is following "([^\"]*)"$/ do |login1, login2|
  @first_user = User.find(:first,
                  :conditions => ["UPPER(login) = ?", login1.upcase])
  @second_user = User.find(:first,
                  :conditions => ["UPPER(login) = ?", login2.upcase])
  @second_user.add_follower(@first_user)  
  @second_user.save
  @first_user.is_following?(@second_user).should == true
  
end

