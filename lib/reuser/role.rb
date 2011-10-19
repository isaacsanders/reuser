require_relative('../reuser')

module ReUser
  class Role
    attr_reader :actions

    def initialize(name)
      @name = name
      @actions = {}
    end

    def can(*names)
      actions(*names)
    end

    def can?(name)
      actions[name]
    end

    def could(*names, &test)
      names.each do |name|
        action(name, test)
      end
    end

    def could?(name, data)
      actions[name].is_a?(Proc) ? actions[name].call(data) : true
    end

    private
      def actions(*names)
        names.each do |name|
          action(name)
        end
        @actions
      end

      def action(name, test = true)
        @actions[name] = test
      end
  end
end
