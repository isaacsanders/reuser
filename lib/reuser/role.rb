module ReUser
  class Role
    def initialize *permissions
      @permissions = {}
      self.can *permissions
    end

    def can *permissions
      permissions.each do |permission|
        @permissions[permission] = lambda {|*args| true }
      end
    end

    def can? permission
      @permissions.has_key?(permission) && @permissions[permission].is_a?(Proc)
    end

    def could permission, &block
      raise "#could requires a block" unless block_given?
      @permissions[permission] = block
    end

    def could? permission, *block_args
      if @permissions.has_key?(permission)
        @permissions[permission].call(*block_args)
      else
        false
      end
    end
    alias_method :able_to?, :could?
  end
end
