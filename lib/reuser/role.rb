module ReUser
  class Role
    attr_reader :name

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
  end
end
