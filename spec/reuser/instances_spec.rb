require 'spec_helper'

describe "Instances of a Class including ReUser" do
  let(:klass) do
    kls = Class.new
    kls.instance_eval do
      include ReUser

      roles do
        role :admin do |admin|
          admin.can :read
          admin.could :write do |language|
            language == "English"
          end
        end
      end

      define_method :role do
        kls.role(:admin)
      end
    end
    kls
  end

  subject do
    instance = klass.new
    instance
  end

  specify "#can? is delegated to the ReUser::Role" do
    subject.role.should_receive :can?
    subject.can? :read
  end

  specify "#could? is delegated to the ReUser::Role" do
    subject.role.should_receive :could?
    subject.could? :write, 'Farsi'
  end

  specify "#cant? is #can? negated" do
    subject.can?(:write).should == !(subject.cant? :write)
  end

  specify "#couldnt? is #could? negated" do
    subject.could?(:write, 'Farsi').should == !(subject.couldnt? :write, 'Farsi')
  end
end
