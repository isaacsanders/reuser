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
      @permissions[permission] = true
    end

    def can? permission
      @permissions[permission]
    end

    def could permission, &block
    end

    def could? permission, block_args
    end
  end
end
