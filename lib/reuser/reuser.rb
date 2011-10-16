require_relative('../reuser')

module ReUser
  class NoRoleError < StandardError; end;
  class NoDefaultRoleError < StandardError; end;
  instance_eval do
    def included(subclass)
      subclass.instance_eval do
        @@roles = {}
        def roles(&block)
          @@roles ||= {}
          yield if block
          @@roles.freeze
          @@roles.keys
        end

        def role(name, actions_list = nil, &block)
          @@roles[name] ||= ReUser::Role.new(name)
          role_name = @@roles[name]
          yield(role_name) if block
          if actions_list
            role_name.can(*actions_list)
          end
          role_name
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

        def role?(name)
          @role == self.class.role(name)
        end

        def can?(name)
          !!@role.can?(name)
        end

        def cant?(name)
          !@role.can?(name)
        end

        def could?(name, obj)
          @role.could?(name, obj)
        end

        def couldnt?(name, obj)
          !@role.could?(name, obj)
        end
      end
    end
  end
end
