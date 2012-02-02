require_relative '../spec_helper'

describe "Instances of a Class including ReUser" do
  let(:klass) do
    kls = Class.new
    kls.instance_eval do
      include ReUser

      roles do
        role :admin do |admin|
          admin.can :read
        end
      end
    end
    kls
  end

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
      subject.can?(:read).should be_true
    end

    it "if the role does not define the permission, returns false" do
      subject.can?(:write).should be_false
    end
  end
end
