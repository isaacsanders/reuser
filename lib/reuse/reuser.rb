require_relative(reuse_file = '../reuse')

module ReUser
  instance_eval do
    def included(subclass)
      subclass.instance_eval do
        def roles(&block)
          @@roles ||= {}
          yield if block
          @@roles.keys
        end

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

        def initialize(role = :default)
          unless @role = @@roles[role.to_sym]
            if role == :default
              raise NoDefaultRoleError, "No default role is declared for #{self}"
            end
            raise NoRoleError, "#{role} is not a declared role for #{self}"
          end
        end

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
class NoRoleError < StandardError; end;
class NoDefaultRoleError < StandardError; end;
end
