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

    its(:roles) { should === klass.class_variable_get(:@@roles)}

    context "with no roles defined" do
      its(:roles) { should === [] }
    end

    context ".role" do
      it "takes a symbol" do
        lambda { subject.role(:admin) }.should_not raise_error
      end

      it "returns a ReUser::Role instance" do
        subject.role(:admin).should be_instance_of ReUser::Role
      end
    end
  end
end
