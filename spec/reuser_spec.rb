require 'spec_helper'

describe ReUser do
  context "A class that includes ReUser" do
    let(:klass) do
      class TestObject
        include ReUser
      end

      TestObject
    end
    subject { klass }

    context "with no roles defined" do
      its(:roles) { should === [] }
    end

    context ".roles" do
      it "optionally takes a block" do
        lambda { subject.roles { :good } }.should_not raise_error
        lambda { subject.roles }.should_not raise_error
      end

      it "returns an array" do
        subject.roles.should be_kind_of Array
      end
    end

    context ".role" do
      subject { klass.role(:admin) }

      it "takes a symbol" do
        lambda { subject }.should_not raise_error
      end

      it "returns a ReUser::Role instance" do
        subject.should be_instance_of ReUser::Role
      end
    end
  end
end
