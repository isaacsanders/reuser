module ReUser
  class Role
    attr_reader :name

    def permissions
      @permissions.keys
    end

    def initialize name
      @name = name
      @permissions = {}
    end

    def can permission
      @permissions[permission] = lambda {|*args| true }
    end

    def can? permission
      @permissions[permission].is_a? Proc
    end

    def could permission, &block
      @permissions[permission] = block
    end

    def could? permission, block_args
      @permissions[permission].call(block_args)
    end
  end
end
