require 'spec_helper'

describe ReUser do
  let(:klass) do
    kls = Class.new
    kls.instance_eval do
      include ReUser

      roles do
        role(:admin)
      end
    end
    kls
  end

  context "Classes including ReUser" do
    subject { klass }

    context ".roles" do
      it "optionally takes a block" do
        lambda { subject.roles { :good } }.should_not raise_error
        lambda { subject.roles }.should_not raise_error
      end

      it "returns an array of role names" do
        subject.roles.should be_kind_of Array
        subject.roles.all? {|el| el.is_a? Symbol}.should be_true
      end
    end

    context ".role" do

      it "takes a symbol" do
        lambda { subject.role(:admin) }.should_not raise_error
      end

      it "returns a ReUser::Role instance" do
        subject.role(:admin).should be_instance_of ReUser::Role
      end

      context "passing in a role that is already defined" do
        it "returns the same role" do
          expected = subject.role(:admin)
          subject.role(:admin).should === expected
        end
      end

      context "passing in a role that is not already defined" do
        it "raises an error" do
          subject.class_eval do
            roles do
              role(:admin)
            end
          end
          lambda { subject.role(:user) }.should raise_error
        end
      end
    end
  end

  context "Instances of a Class including ReUser" do
    subject do
      instance = klass.new
      instance.instance_variable_set(:@role, klass.role(:admin))
      instance
    end

    context "#can?" do
      it "takes a symbol" do
        lambda { subject.can? }.should raise_error(ArgumentError)
        lambda { subject.can? :read }.should_not raise_error
      end

      it "if the role has the permission defined, returns true" do
        klass.roles do
          klass.role :admin do |admin|
            admin.can :read
          end
        end
      end
    end
  end
end
