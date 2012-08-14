require 'spec_helper'

describe ReUser::RoleDefinition do
  subject do
    definition = proc do
      role :foo
    end

    described_class.new definition
  end

  describe '#role' do
    it "takes a symbol, and an optional array" do
      puts subject
      lambda { subject.role(:admin, [:read, :write]) }.should_not raise_error
    end
  end
end
