require_relative '../spec_helper'

describe ReUser::Role do
  subject do
    role = ReUser::Role.new(:admin)
    role.can(:read)
    role
  end

  it 'is initialized with a name, and optionally an array of permissions' do
    role = ReUser::Role.new :admin
    role.name.should == :admin
    role.permissions.should == []

    role = ReUser::Role.new :user
    role.name.should == :user
    role.permissions.should == []

    role = ReUser::Role.new :user, [:read, :write]
    role.name.should == :user
    role.permissions.should == [:read, :write]
  end

  context 'shares its name and permissions' do
    its(:name) { should === :admin }
    its(:permissions) { should === [:read] }
  end

  it 'permissions are added and checked with #can and #can?' do
    subject.can?(:read).should be_true
    subject.can?(:write).should be_false
    subject.can(:write)
    subject.can?(:write).should be_true
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
