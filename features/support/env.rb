$: << 'lib'
require 'reuser'

After do
  User.instance_eval do
    class_variable_set(:@@roles, nil)
  end
end
