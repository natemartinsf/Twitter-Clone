Given /^a logged\-in user named "([^\"]*)"$/ do |username|
  @user = User.create!(:login => username, :email => username+'@test.gov', :password => 'testme', :password_confirmation => 'testme')
  @user.save!
  @user_session = UserSession.new(:login => username, :password => 'testme' )
  @user_session.save
  
end

Given /^a status for "([^\"]*)" with content "([^\"]*)"$/ do |login, content|
  user = user_from_login(login)
  status = Status.new(:content=>content)
  status.user = user
  status.save!
end

Then /^"([^\"]*)" should have "([^\"]*)" mention\(s\)$/ do |login, count|
  user = user_from_login(login)
  user.mentions.length.should == count.to_i
end

Then /^there should not be hashtag called "([^\"]*)"$/ do |tag|
  Hashtag.find(:all,
                  :conditions => ["tag = ?", tag]).count.should equal 0
end

Then /^there should be a hashtag called "([^\"]*)"$/ do |tag|
  Hashtag.find( :all,
                :conditions => ["tag = ?", tag]).count.should equal 1
end

Then /^"([^\"]*)" should have "([^\"]*)" statuses$/ do |tag, status_count|
  Hashtag.find( :first,
                :conditions => ["tag = ?", tag]).statuses.count.should equal status_count.to_i
end


#Given /^the following posts:$/ do |posts|
#  Post.create!(posts.hashes)
#end

#When /^I delete the (\d+)(?:st|nd|rd|th) post$/ do |pos|
#  visit posts_url
#  within("table > tr:nth-child(#{pos.to_i+1})") do
#    click_link "Destroy"
#  end
#end

#Then /^I should see the following posts:$/ do |expected_posts_table|
#  expected_posts_table.diff!(table_at('table').to_a)
#end


def user_from_login(login)
  return User.find(:first,
                  :conditions => ["UPPER(login) = ?", login.upcase])
end