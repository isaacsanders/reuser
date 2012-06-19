Then /^I should have know my role's name is "([^"]*)"$/ do |expected|
  @actual.should == expected.to_sym
end

Then /^I should know that admins can read and write$/ do
  @actual.should =~ [:read, :write]
end
