require_relative '../spec_helper'

describe "Classes including ReUser" do
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
