require_relative "./reuser/role"

module ReUser

  def self.included klass
    klass.instance_eval do
      def roles &block
        @@roles ||= {}
        yield if block_given?
        @@roles.values
      end

      def role name
        @@roles[name] = ReUser::Role.new
      end
    end
  end
end
