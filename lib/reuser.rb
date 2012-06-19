require_relative "./reuser/role"

module ReUser

  def self.included klass

    klass.instance_eval do
      def roles &block
        @@roles ||= {}
        yield if block_given?
        @@roles.freeze.keys
      end

      def role name, permissions=[], &block
        role = ( @@roles[name] ||= ReUser::Role.new(name, permissions) )
        yield(role) if block_given?
        role
      end
    end
  end

  def can? permission
    self.role.can? permission
  end

  def cant? permission
    !(can? permission)
  end

  def could? permission, block_args
    self.role.could? permission, block_args
  end

  def couldnt? permission, block_args
    !(could? permission, block_args)
  end
end
