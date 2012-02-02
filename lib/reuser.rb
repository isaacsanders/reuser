require_relative "./reuser/role"

module ReUser

  def self.included klass
    klass.instance_eval do
      def roles &block
        @@roles ||= {}
        yield if block_given?
        @@roles.freeze
        @@roles.keys
      end

      def role name, &block
        @@roles[name] ||= ReUser::Role.new name
        role = @@roles[name]
        yield(role) if block_given?
        role
      end
    end
  end

  def can? permission
    @role.can? permission
  end
end
