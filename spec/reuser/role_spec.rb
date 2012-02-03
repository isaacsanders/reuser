require_relative '../spec_helper'

describe ReUser::Role do
  subject do
    role = ReUser::Role.new(:admin)
    role.can(:read)
    role
  end

  it 'is initialized with a name' do
    role = ReUser::Role.new :admin
    role.name.should === :admin

    role = ReUser::Role.new :user
    role.name.should === :user
  end

  context 'shares its name and permissions' do
    its(:name) { should === :admin }
    its(:permissions) { should === [:read] }
  end

  it 'permissions are added and checked with #can and #can?' do
    subject.can?(:read).should be_true
  end
end
