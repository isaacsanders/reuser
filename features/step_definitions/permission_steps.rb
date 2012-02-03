When /^I ask if the user could write "([^"]*)"$/ do |language|
  @expected = @user.could? :write, language
end

When /^I create an? "([^"]*)" user$/ do |role_name|
  @user = User.new(role_name.to_sym)
end

When /^I ask if the user can read$/ do
  @expected = !!(@user.can? :read)
end

Then /^I learn that they can't$/ do
  @expected.should be_false
end

Then /^I learn that they can$/ do
  @expected.should be_true
end
