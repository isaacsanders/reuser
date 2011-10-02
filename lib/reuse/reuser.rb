require_relative(reuse_file = '../reuse')

# Look into ActiveSupport::Concern for a more modern module inclusion pattern
# http://rubydoc.info/docs/rails/ActiveSupport/Concern
# It's cleaner and definitely preferred.

# Where are the roles listed? Is there an app-wide key that shows what roles are available?

module ReUser
  instance_eval do
    def included(subclass)
      subclass.instance_eval do
        def roles(&block)
          @@roles ||= {}
          yield if block
          @@roles.keys
        end

        # Perhaps my preference, but I like to see block parameters listed as `&block`
        # What is the point of `yield(new role)`? I don't think that actually does anything
        # I would rewrite this as:
        # @@roles[name] = Role.new(name)
        def role(name, &actions)
          new_role = Role.new(name)
          yield(new_role)
          @@roles[name] = new_role
        end

        def default(name = nil)
          if name
            @@roles[:default] = @@roles[name]
          else
            @@roles[:default]
          end
        end
      end
      subclass.class_eval do
        attr_reader :role

        # Don't confuse accessors with instance variables
        # I don't exactly follow what is happening here?
        def initialize(role = :default)
          unless @role = @@roles[role.to_sym]
            if role == :default
              raise NoDefaultRoleError, "No default role is set for #{self}"
            end
            raise NoRoleError, "#{role} is not a declared role for #{self}"
          end
        end

        # All you need to write here is `@role.actions.has_key?(name)`
        def can?(name)
          if @role.actions[name]
            true
          else
            false
          end
        end
      end
    end
  end

# Another usual preference is to declare custom error classes at the top of the
# containing class. Also watch the indenting.
class NoRoleError < StandardError; end;
class NoDefaultRoleError < StandardError; end;
end
