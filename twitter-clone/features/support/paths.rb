module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in webrat_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the homepage/
      '/'
    when /the new test page/
      new_test_path

    when /the new test page/
      new_test_path

    when /the new users page/
      new_users_path

    when /the new users page/
      new_users_path

    when /the new post page/
      new_post_path

    when /the new post page/
      new_post_path

    when /the register user page/
      new_account_path
      
    when /the login page/
      new_user_session_path
      
    when /the status page for "(.*)"/i 
      statuses_path(:login=>$1)
    
    when /the hashtag page for "(.*)"/i 
      hashtag_path(:hashtag=>$1)    

    when /the new frooble page/
      new_frooble_path

    
    # Add more mappings here.
    # Here is a more fancy example:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
