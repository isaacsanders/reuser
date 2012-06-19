require "reuser/role"

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

  def permissions
    self.class.role(self.role.to_sym).permissions
  end

  def can? permission
    self.class.role(self.role.to_sym).can? permission
  end

  def cant? permission
    !(can? permission)
  end

  def could? permission, block_args
    self.class.role(self.role.to_sym).could? permission, block_args
  end

  def couldnt? permission, block_args
    !(could? permission, block_args)
  end
end
