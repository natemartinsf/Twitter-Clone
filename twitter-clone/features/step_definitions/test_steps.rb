Given /^the following tests:$/ do |tests|
  Test.create!(tests.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) test$/ do |pos|
  visit tests_url
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following tests:$/ do |expected_tests_table|
  expected_tests_table.diff!(table_at('table').to_a)
end
