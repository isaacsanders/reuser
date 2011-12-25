require 'rspec'
require 'pry'
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
    default(:user)
  end

  def initialize(name = :default)
    @role = TestReUser.role(name)
  end
end

describe TestReUser do
  context "has included the ReUser module" do
    it "should be able to define roles with blocks" do
      test_ru = TestReUser.new(:admin)
      test_ru.can?(:read).should == true
    end

    it "should be able to define roles with arrays" do
      test_ru = TestReUser.new(:admin)
      test_ru.can?(:read).should == true
    end

    context "has defined the :admin and :user roles," do
      context "is instantiated as test_ru" do
        context "set :user to the default" do
          before do
            @test_ru = TestReUser.new
          end
          context " using the default role" do
            it "should not be able to write" do
              @test_ru.cant?(:write).should == true
            end

            it "should be able to read" do
              @test_ru.can?(:read).should == true
            end

            it "should not be able to call methods restricted to `:admin` roles" do
              class InsufficientPermissionsError < StandardError;end
              TestReUser.class_eval do
                def foo
                  if @role == :admin
                    :something
                  else
                    raise InsufficientPermissionsError, "You can't do that!"
                  end
                end
              end

              lambda {@test_ru.foo}.should raise_error(InsufficientPermissionsError)
            end
          end

          it "should be able to execute on a 1 object." do
            @test_ru.could?(:execute, 1).should == true
            @test_ru.couldnt?(:execute, 3).should == true
          end
        end

        context "set role to :admin" do
          before do
            @test_ru = TestReUser.new :admin
          end
          it "should be able to read, write, and execute" do
            @test_ru.can?(:read).should == true
            @test_ru.can?(:write).should == true
            @test_ru.can?(:execute).should == true
          end
        end
      end
    end
  end
end
