Given /^the following class:$/ do |class_code|
  eval class_code, binding, "feature_user_class"
end

When /^I access "([^"]*)"$/ do |access_code|
  begin
    @expected = eval access_code
  rescue Exception => e
    @expected = e
  end
end

Then /^I should get an error$/ do
  @expected.should be_kind_of Exception
end

Then /^I should have an array of (\d+ roles?)$/ do |role_count|
  @expected.should have(role_count).items
  @expected.all? do |item|
    item.should be_instance_of Symbol
  end
end

Transform /(\d+) roles?/ do |role_count|
  Integer(role_count)
end

