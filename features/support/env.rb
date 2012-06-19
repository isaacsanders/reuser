$: << 'lib'
require 'reuser'

After do
  User.class_variable_set(:@@roles, nil)
end
