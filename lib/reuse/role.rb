require_relative(reuse_file = '../reuse')

module ReUser
  class Role
    attr_reader :actions

    def initialize(name)
      @actions = {}
    end

    def actions(*names)
      names.each do |name|
        action(name)
      end
      @actions
    end

    def action(name)
      @actions[name] = true
    end
  end
end
