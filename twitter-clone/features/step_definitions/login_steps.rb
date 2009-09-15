Given /^no user "([^\"]*)"$/ do |login|
  lambda{ User.find(login) }.should raise_error(ActiveRecord::RecordNotFound)
end



Then /^the user "([^\"]*)" can log in with password "([^\"]*)"$/ do |login, password|
  visit new_user_session_path
  fill_in "Login", :with => login
  fill_in "Password", :with => password
  click_button "Login"
  response.should contain("Login successful!")
end

Given /^a valid user$/ do
  @user = User.create!(:login => 'testuser', :email => 'blahblah@test.gov', :password => 'testme', :password_confirmation => 'testme')
end


Given /^a valid user named "([^\"]*)"$/ do |user|
  @user = User.create!(:login => user, :email => user+'@test.gov', :password => 'testme', :password_confirmation => 'testme')
end

Given /^I submit the login form for "([^\"]*)"$/ do |login|
  fill_in "Login", :with => login
  fill_in "Password", :with => "testme"
  click_button "Login"
  response.should contain("Login successful!")
end



When /^I submit the login form$/ do
  fill_in "Login", :with => @user.login
  fill_in "Password", :with => @user.password
  click_button "Login"
  response.should contain("Login successful!")
end

Given /^I submit the login form with false data$/ do
  fill_in "Login", :with => "fake!"
  fill_in "Password", :with => "wrong!"
  click_button "Login"
end
