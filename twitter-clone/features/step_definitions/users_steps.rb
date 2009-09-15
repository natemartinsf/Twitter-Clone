Then /^I should be following "([^\"]*)"$/ do |login|
  followed_user = User.find(:first,
                  :conditions => ["UPPER(login) = ?", login.upcase])
  followed_user.followers.find(:first,
                  :conditions => ["login = ?", @user.login])
end
