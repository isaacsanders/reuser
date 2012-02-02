When /^I create an? "([^"]*)" user$/ do |role_name|
  @user = User.new(role_name.to_sym)
end

When /^I ask if the user can read$/ do
  @expected = !!(@user.can? :read)
end

Then /^I learn that the user can't read$/ do
  @expected.should be_false
end

Then /^I learn that the user can read$/ do
  @expected.should be_true
end
