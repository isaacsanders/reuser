if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter '/spec/'
    add_filter '/features/'
  end
end
$: << 'lib'
require 'reuser'

After do
  User.instance_eval do
    class_variable_set(:@@roles, nil)
  end
end
