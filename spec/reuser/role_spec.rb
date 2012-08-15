require 'spec_helper'

describe ReUser::Role do
  subject do
    role = ReUser::Role.new
    role.can(:read)
    role
  end

  it 'is initialized with an optional array of permissions' do
    role = ReUser::Role.new :read, :write
    role.should be_able_to :read
    role.should be_able_to :write
  end

  it 'permissions are added and checked with #can and #can?' do
    subject.should be_able_to :read
    subject.should_not be_able_to :write
    subject.can(:write)
    subject.should be_able_to :write
  end

  it 'you need to supply #could with a test block' do
    lambda { subject.could(:read) }.should raise_error
  end

  it 'conditional permissions are added and checked with #could and #could?' do
    subject.can?(:write).should be_false
    subject.could :write do |language|
      language == "English"
    end
    subject.can?(:write).should be_true
    subject.could?(:write, "Japanese").should be_false
    subject.could?(:write, "English").should be_true
  end
end
