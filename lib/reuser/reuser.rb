require_relative('../reuser')

module ReUser
  class NoRoleError < StandardError; end;
  class NoDefaultRoleError < StandardError; end;
  instance_eval do
    def included(subclass)
      subclass.instance_eval do
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
      end
      subclass.class_eval do

        def can?(action)
          !!@role.can?(action)
        end

        def cant?(action)
          !@role.can?(action)
        end

        def could?(action, obj)
          !!@role.could?(action, obj)
        end

        def couldnt?(action, obj)
          !@role.could?(action, obj)
        end
      end
    end
  end
end
