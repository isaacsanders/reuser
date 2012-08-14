module ReUser
  class Error < StandardError; end
  class RoleNotDefined < Error
    def initialize(name)
      @name = name
    end

    def message
      "Role `#{@name}` is not defined"
    end
  end
end
