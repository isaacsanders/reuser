module ReUser
  class Role
    attr_reader :name

    def permissions
      @permissions.keys
    end

    def initialize name, permissions=[]
      @name = name
      @permissions = {}
      self.can *permissions
    end

    def can *permissions
      permissions.each do |permission|
        @permissions[permission] = lambda {|*args| true }
      end
    end

    def can? permission
      @permissions[permission].is_a? Proc
    end

    def could permission, &block
      raise "#could requires a block" unless block_given?
      @permissions[permission] = block
    end

    def could? permission, block_args
      @permissions[permission].call(block_args)
    end
  end
end
