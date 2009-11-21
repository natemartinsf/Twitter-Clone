def user
  @user ||= Factory :user
end

def custom_user(name)
  @custom_user  = Factory(:user, :login=>name, :email=>name+"@example.com")
end

def login
  user
  visit path_to("the homepage")
  response.should contain("Log in")
  click_link "Log in"
  fill_in "Login", :with => "john" 
  fill_in "Password", :with => "funkypass"
  click_button "Login"
  response.should contain("Login successful!")
  response.should contain("Logout")
end

def custom_login(name)
  visit path_to("the homepage")
  response.should contain("Log in")
  click_link "Log in"
  fill_in "Login", :with => name
  fill_in "Password", :with => "funkypass"
  click_button "Login"
  response.should contain("Login successful!")
  response.should contain("Logout")
end


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
  user
end

Then /^the user should be logged in$/ do
  @the_user = User.find(:first,
                  :conditions => ["login = ?", 'testuser'])
  @current_user.should equal(@the_user)
end


Given /^a valid user named "([^\"]*)"$/ do |user|
  custom_user(user)
end

Given /^I submit the login form for "([^\"]*)"$/ do |login|
  login
end

Given /^I am logged in$/ do
  login
end

Given /^I am logged in as "([^\"]*)"$/ do |login|
  custom_login(login)
end


Given /^a logged in user named "([^\"]*)"$/ do |user|
  @new_user = User.find(:first,
                  :conditions => ["UPPER(login) = ?", user.upcase])
  
  @user_session = UserSession.create(:email => user+'@example.com', :password => 'password')
  @user_session.save
  @current_user = @new_user
  puts @current_user
  
end



When /^I login$/ do
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





def createuser(login)
  return User.create!(:login => login, :email => login+'@test.gov', :password => 'testme', :password_confirmation => 'testme')
end

