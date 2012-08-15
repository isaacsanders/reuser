Given /^the following class:$/ do |class_code|
  eval class_code, binding, "feature_user_class"
end

When /^I access "([^"]*)"$/ do |access_code|
  begin
    @actual = eval access_code
  rescue Exception => e
    @actual = e
  end
end

Then /^I should get an error$/ do
  @actual.should be_kind_of Exception
end

Then /^I should know that an admin can read, write, and execute$/ do
  [:read, :write, :execute].each do |permission|
    User.role(:admin).should be_able_to permission
  end
end

Then /^I should have an array of (\d+ roles?)$/ do |role_count|
  @actual.should have(role_count).items
  @actual.all? do |item|
    item.should be_instance_of Symbol
  end
end

Transform /(\d+) roles?/ do |role_count|
  Integer(role_count)
end

