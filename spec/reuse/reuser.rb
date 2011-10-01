require 'rspec'
require_relative '../reuse'

describe "Class TestReUser" do
  context "has not included the ReUser module" do
    it "should not have ReUser methods" do
      class TestReUser; end
      methods = TestReUser.public_methods - Object.public_methods
      methods.include?(:role).should == false
      methods.include?(:roles).should == false
    end
  end

  context "has included the ReUser module" do
    before do
      class TestReUser; include ReUser; end
    end

    it "should have the ReUser methods" do
      methods = TestReUser.public_methods - Object.public_methods
      methods.include?(:role).should == true
      methods.include?(:roles).should == true
    end

    it "should be able to define roles" do
      TestReUser.class_eval do
        roles do
          role(:admin) {|r| r.actions(:read, :write, :execute)}
          role(:user) {|r| r.action(:read)}
        end
      end

      TestReUser.roles.should == [:admin, :user]
    end

    context "has defined the :admin and :user roles," do
      before do
        TestReUser.class_eval do
          roles do
            role(:admin) {|r| r.actions(:read, :write, :execute)}
            role(:user) {|r| r.action(:read)}
          end
        end
      end


      context "is instantiated as test_ru" do
        context "set :user to the default" do
          before do
            TestReUser.class_eval do
              roles do
                default(:user)
              end
            end

            @test_ru = TestReUser.new
          end

          context " using the default role" do

            it "should not be able to write" do
              @test_ru.can?(:write).should_not == true
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
        end

        context "set role to :admin" do
          before do
            @test_ru = TestReUser.new(:admin)
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
