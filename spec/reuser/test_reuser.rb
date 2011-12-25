require_relative '../reuser'

class TestReUser
  include ReUser

  roles do
    role(:admin).can(:read, :write, :execute)
    role(:user) do |usr|
      usr.can :read

      usr.could :execute do |obj|
        obj == 1
      end
    end
    role :writer, :write
    role :sysadmin, [:write, :execute]
  end

  def initialize(name)
    @role = TestReUser.role(name)
  end
end
