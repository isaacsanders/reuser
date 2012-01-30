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

      def role name
        @@roles[name] ||= ReUser::Role.new
      end
    end
  end

  def can? permission
  end
end
