require 'reuser/role'

module ReUser
  class RoleDefinition
    def initialize(definition)
      @roles = {}
      instance_eval &definition
    end

    def roles
      @roles
    end

    def role name, permissions=[], &block
      role = ReUser::Role.new(*permissions)
      role.instance_eval &block if block_given?
      @roles[name] = role
    end
  end
end
