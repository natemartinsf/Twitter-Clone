Given /^a logged\-in user named "([^\"]*)"$/ do |username|
  @user = User.create!(:login => username, :email => username+'@test.gov', :password => 'testme', :password_confirmation => 'testme')
  @user.save!
  @user_session = UserSession.new(:login => username, :password => 'testme' )
  @user_session.save
  
end

Given /^a status for "([^\"]*)" with content "([^\"]*)"$/ do |login, content|
  user = User.find(:first,
                  :conditions => ["UPPER(login) = ?", login.upcase])
  status = Status.new(:content=>content)
  status.user = user
  status.save!
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
