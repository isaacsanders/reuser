require_relative '../spec_helper'

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
    end
    kls
  end

  subject do
    instance = klass.new
    instance.instance_variable_set(:@role, klass.role(:admin))
    instance
  end

  it "#can? and #could? are delegated to the ReUser::Role" do
    true
  end

  it "#cant? and #couldnt? are negations of #can? and #could?" do
    true
  end
end
