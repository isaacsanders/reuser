require 'spec_helper'

describe ReUser do
  def klass
    kls = Class.new
    kls.instance_eval do
      include ReUser
      class_variable_set(:@@roles, nil)
      roles
    end
    kls
  end

  context ".roles" do
    it "optionally takes a block" do
      lambda { klass.roles { :good } }.should_not raise_error
      lambda { klass.roles }.should_not raise_error
    end

    it "returns an array" do
      klass.roles.should be_kind_of Array
    end
  end

  context ".role" do

    it "takes a symbol" do
      lambda { klass.role(:admin) }.should_not raise_error
    end

    it "returns a ReUser::Role instance" do
      klass.role(:admin).should be_instance_of ReUser::Role
    end

    it "if a role is already defined, it raises an error" do
      lambda do
        klass.roles do
          role(:admin)
          role(:admin)
        end
      end.should raise_error
    end
  end
end
