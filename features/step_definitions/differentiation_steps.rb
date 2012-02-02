Then /^I should have know my role's name is "([^"]*)"$/ do |expected|
  @actual.should == expected.to_sym
end

