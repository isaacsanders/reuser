require 'reuser/role_definition'
require 'reuser/errors'

module ReUser
  module ClassMethods
    def roles &definition_block
      if block_given?
        definition = ReUser::RoleDefinition.new(definition_block)
        @@roles = definition.roles
      else
        @@roles.keys
      end
    end

    def role(name)
      @@roles.fetch(name.to_sym)
    rescue ::IndexError
      raise RoleNotDefined.new(name)
    end
  end

  def self.included(base)
    base.extend ReUser::ClassMethods
  end

  def can? permission
    self.class.role(self.role).can? permission
  end

  def cant? permission
    !can?(permission)
  end

  def could? permission, *block_args
    if block_args.empty?
      block_args << self
    end
    self.class.role(self.role).could? permission, *block_args
  end
  alias_method :able_to?, :could?

  def couldnt? permission, *block_args
    !could?(permission, *block_args)
  end
end
