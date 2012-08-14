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
      role = ReUser::Role.new(name, permissions)
      yield(role) if block_given?
      @roles[name] = role
    end
  end
end
